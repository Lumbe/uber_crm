require 'rails_helper'

RSpec.describe CommercialProposalsController, type: :controller do
  login_user('manager')
  before :each do
    @user = subject.current_user
    @contact = create(:contact, department_id: @user.current_department_id)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { contact_id: @contact.id }
      expect(response).to have_http_status(:success)
    end

    it "renders 'new' template" do
      get :new, params: { contact_id: @contact.id }
      expect(response).to render_template(:new)
    end

    it "assigns a new commercial_proposal to @commercial_proposal" do
      get :new, params: { contact_id: @contact.id }
      expect(assigns(:commercial_proposal)).to be_a_new(CommercialProposal)
    end
  end

  describe "POST #create" do

    context "with valid attributes" do
      it "saves new commercial_proposal to database" do
        post :create, params: { contact_id: @contact.id, user_id: @user.id, commercial_proposal: attributes_for(:commercial_proposal) }
        expect(CommercialProposal.count).to eq(1)
      end

      it "redirects to created commercial proposal" do
        post :create, params: { contact_id: @contact.id, user_id: @user.id, commercial_proposal: attributes_for(:commercial_proposal) }
        expect(response).to redirect_to contact_commercial_proposal_path(assigns(:contact), assigns(:commercial_proposal))
      end

    end

    context "with invalid attributes" do
      it "don't save invalid commercial_proposal to database" do
        post :create, params: { contact_id: @contact.id, user_id: @user.id, commercial_proposal: attributes_for(:invalid_commercial_proposal) }
        expect(CommercialProposal.count).to eq(0)
      end

      it "renders new template" do
        post :create, params: { contact_id: @contact.id, user_id: @user.id, commercial_proposal: attributes_for(:invalid_commercial_proposal) }
        expect(response).to render_template(:new)
      end
    end

  end

  describe "GET #show" do
    it "returns http success" do
      commercial_proposal = create(:commercial_proposal)
      get :show, params: { id: commercial_proposal.id, contact_id: @contact.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested commercial_proposal to @commercial_proposal" do
      commercial_proposal = create(:commercial_proposal)
      get :show, params: { id: commercial_proposal.id, contact_id: @contact.id }
      expect(assigns(:commercial_proposal)).to eq(commercial_proposal)
    end

    it "renders :show" do
      commercial_proposal = create(:commercial_proposal)
      get :show, params: { id: commercial_proposal.id, contact_id: @contact.id }
      expect(response).to render_template('show')
    end
  end

  describe "GET #send_by_email" do
    login_user("manager")

    before :each do
      @user = subject.current_user
      @contact = create(:contact, department_id: @user.current_department_id)
      @commercial_proposal = create(:commercial_proposal, user: @user, contact: @contact)
      clear_enqueued_jobs
    end

    it 'locates the requested @user' do
      get :send_by_email, params: { contact_id: @contact.id, commercial_proposal_id: @commercial_proposal.id }
      expect(assigns(:user)).to eq(@user)
    end

    it 'locates the requested @contact' do
      get :send_by_email, params: { contact_id: @contact.id, commercial_proposal_id: @commercial_proposal.id }
      expect(assigns(:contact)).to eq(@contact)
    end

    it 'locates the requested @commercial_proposal' do
      get :send_by_email, params: { contact_id: @contact.id, commercial_proposal_id: @commercial_proposal.id }
      expect(assigns(:commercial_proposal)).to eq(@commercial_proposal)
    end

    it "enque commercial_proposal's email" do
      get :send_by_email, params: { contact_id: @contact.id, commercial_proposal_id: @commercial_proposal.id }
      expect(enqueued_jobs.size).to eq(1)
    end

    it "creates comment for contact with sended commercial_proposal" do
      get :send_by_email, params: { contact_id: @contact.id, commercial_proposal_id: @commercial_proposal.id }
      expect(@contact.comments.size).to be >= 0
    end
  end

end
