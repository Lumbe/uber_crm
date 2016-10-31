require 'rails_helper'

RSpec.describe LeadsController, type: :controller do

  describe "GET #index" do
    context "valid user" do
      login_user("manager")

      it "responds succesfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "populates @leads" do
        user = subject.current_user
        lead = create(:lead, user: user, department_id: user.current_department_id)
        get :index, format: :json, params: {statuses: Lead.statuses.keys, start: 60.days.ago, end: Time.zone.now  }
        expect(assigns(:leads)).to eq([lead])
      end
    end

    context "invalid user" do
      login_user("visitor")

      it "redirects to unauthorized page" do
        get :index
        expect(response).to redirect_to("/unauthorized")
      end
    end
  end

  describe "GET #show" do
    login_user("manager")

    it "assigns the requested lead to @lead" do
      lead = create(:lead, department_id: subject.current_user.current_department_id)
      get :show, params: { id: lead.id }
      expect(assigns(:lead)).to eq(lead)
    end

    it "renders :show" do
      lead = create(:lead, department_id: subject.current_user.current_department_id)
      get :show, params: { id: lead.id }
      expect(response).to render_template('show')
    end
  end

  describe "GET #new" do
    login_user('manager')
    
    it "assigns a new Lead to @lead" do
      get :new
      expect(assigns(:lead)).to be_a_new(Lead)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    login_user("manager")

    context "with valid attributes" do
      it "saves new lead to database" do
        user = subject.current_user
        post :create, params: { lead: attributes_with_foreign_keys(:lead, user: user, department_id: user.current_department_id) }
        expect(Lead.count).to eq(1)
      end

      it "redirects to created lead" do
        user = subject.current_user
        post :create, params: { lead: attributes_with_foreign_keys(:lead, user: user, department_id: user.current_department_id) }
        expect(response).to redirect_to(leads_path)
      end

      it 'change status if exists' do
        user = subject.current_user
        contact = create(:contact, email: Faker::Internet.email, department_id: user.current_department_id)
        post :create, params: { lead: attributes_with_foreign_keys(:lead, email: contact.email, department_id: user.current_department_id) }
        expect(assigns(:lead).status).to eq('repeated')
      end

      it 'creates notification' do
        user = subject.current_user
        user2 = create(:user)
        create(:membership, user: user2, department_id: user.current_department_id, role: 'manager')
        post :create, params: { lead: attributes_with_foreign_keys(:lead, user: user, department_id: user.current_department_id) }
        expect(user2.notifications.count).to be > 0
      end

    end

    context "with invalid attributes" do
      it "don't save invalid lead to database" do
        user = subject.current_user
        post :create, params: {lead: attributes_for(:invalid_lead, user: user, department_id: user.current_department_id) }
        expect(Lead.count).to eq(0)
      end

      it "redirects to the 'new' action" do
        user = subject.current_user
        post :create, params: {lead: attributes_for(:invalid_lead, user: user, department_id: user.current_department_id) }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    login_user('manager')
    before :each do
      @lead = create(:lead, name: "Lawrence", department_id: subject.current_user.current_department_id)
    end

    context 'valid attributes' do
      it 'locates the requested lead' do
        put :update, params: { id: @lead, lead: attributes_for(:lead) }
        expect(assigns(:lead)).to eq(@lead)
      end

      it 'changes lead attributes' do
        put :update, params: { id: @lead, lead: attributes_for(:lead, name: 'John') }
        @lead.reload
        expect(@lead.name).to eq('John')
      end

      it 'redirects to the updated lead' do
        put :update, params: { id: @lead, lead: attributes_for(:lead) }
        expect(response).to redirect_to(@lead)
      end
    end

    context 'invalid attributes' do
      it 'locates the requested lead' do
        put :update, params: { id: @lead, lead: attributes_for(:invalid_lead) }
        expect(assigns(:lead)).to eq(@lead)
      end

      it "does not change @lead's attributes"  do
        put :update, params: { id: @lead, lead: attributes_for(:lead, name: "")  }
        @lead.reload
        expect(@lead.name).not_to eq('')
      end

      it "re-renders edit" do
        put :update, params: { id: @lead, lead: attributes_for(:invalid_lead) }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    login_user('manager')
    before :each do
      @lead = create(:lead, name: "Lawrence", department_id: subject.current_user.current_department_id)
    end

    it 'deletes lead' do
      expect { delete :destroy, params: {id: @lead} }.to change{Lead.count}.by(-1)
    end
    
    it 'redirects to index leads' do
      delete :destroy, params: { id: @lead }
      expect(response).to redirect_to(leads_path)
    end
  end

  describe 'GET #claim' do
    login_user('manager')
    before :each do
      @user = subject.current_user
    end

    it 'changes lead status' do
      lead = create(:lead, department_id: @user.current_department_id)
      get :claim, params: { id: lead }
      lead.reload
      expect(lead.status).to eq('claimed')
    end

    it 'set lead assignee' do
      lead = create(:lead, department_id: @user.current_department_id)
      get :claim, params: { id: lead }
      lead.reload
      expect(lead.assignee).to eq(@user)
    end

    it 'redirects to leads index' do
      lead = create(:lead, department_id: @user.current_department_id)
      get :claim, params: { id: lead }
      expect(response).to redirect_to(leads_path)
    end
  end

  describe 'GET #close' do
    login_user('manager')
    before :each do
      @user = subject.current_user
    end

    it 'changes lead status' do
      lead = create(:lead, department_id: @user.current_department_id)
      get :close, params: { id: lead }
      lead.reload
      expect(lead.status).to eq('closed')
    end

    it 'set lead assignee' do
      lead = create(:lead, department_id: @user.current_department_id)
      get :close, params: { id: lead }
      lead.reload
      expect(lead.assignee).to eq(@user)
    end

    it 'redirects to leads index' do
      lead = create(:lead, department_id: @user.current_department_id)
      get :close, params: { id: lead }
      expect(response).to redirect_to(leads_path)
    end
  end

  describe 'GET #close' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      @lead = create(:lead, department_id: @user.current_department_id)
    end

    it 'changes lead status' do
      get :close, params: { id: @lead }
      @lead.reload
      expect(@lead.status).to eq('closed')
    end

    it 'set lead assignee' do
      get :close, params: { id: @lead }
      @lead.reload
      expect(@lead.assignee).to eq(@user)
    end

    it 'redirects to leads index' do
      get :close, params: { id: @lead }
      expect(response).to redirect_to(leads_path)
    end
  end

  describe 'GET #convert' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      @lead = create(:lead, department_id: @user.current_department_id)
    end

    it 'locates the requested lead' do
        get :convert, params: { id: @lead }
        expect(assigns(:lead)).to eq(@lead)
    end

    it 'changes lead status' do
      get :convert, params: { id: @lead }
      @lead.reload
      expect(@lead.status).to eq('converted')
    end

    it 'renders convert view' do
      get :convert, params: { id: @lead }
      expect(response).to render_template('convert')
    end

    it 'populates @contact from @lead' do
      get :convert, params: { id: @lead }
      @lead.reload
      expect(assigns(:contact).attributes.except('id', 'created_at', 'updated_at', 'status', 'proposal_sent')).to eq(@lead.attributes.except('id', 'created_at', 'updated_at', 'status'))
    end

    it 'changes related contact status' do
      contact = create(:contact, email: @lead.email, status: 'finished', department_id: @lead.department_id)
      get :convert, params: { id: @lead }
      contact.reload
      expect(contact.status).to eq('repeated')
    end

    it 'redirects to index contacts if related contact exists' do
      create(:contact, email: @lead.email, department_id: @lead.department_id)
      get :convert, params: { id: @lead }
      expect(response).to redirect_to(contacts_path)
    end

    it 'shows notice if related contact exists' do
      create(:contact, email: @lead.email, department_id: @lead.department_id)
      get :convert, params: { id: @lead }
      expect(flash[:notice]).to be_present
    end
  end

  describe 'GET #delegate' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      @lead = create(:lead, department_id: @user.current_department_id)
    end

    it 'sets delegated lead source' do
      get :delegate, params: { id: @lead }
      expect(assigns(:lead).source).to eq("Передан из #{@lead.department.name}")
    end

    it 'sets delegated lead user' do
      get :delegate, params: { id: @lead }
      expect(assigns(:lead).user).to eq(@user)
    end

    it "sets delegated lead 'newly' status" do
      get :delegate, params: { id: @lead }
      expect(assigns(:lead).status).to eq('newly')
    end

    it 'changes lead status' do
      get :delegate, params: { id: @lead }
      @lead.reload
      expect(@lead.status).to eq('sended')
    end

    it 'renders convert view' do
      get :delegate, params: { id: @lead }
      expect(response).to render_template('delegate')
    end
  end

  describe 'POST #create_delegated_lead' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      @lead = create(:lead, user: @user, department_id: @user.current_department_id)
    end

    context "with valid attributes" do
      it "creates new lead in delegated department" do
        department = create(:department)
        @lead.department_id = department.id
        post :create_delegated_lead, params: { id: @lead, lead: @lead.attributes }
        expect(department.leads.count).to eq(1)
      end

      it 'change status if exists' do
        department = create(:department)
        create(:contact, email: @lead.email, department: department)
        @lead.department_id = department.id
        post :create_delegated_lead, params: { id: @lead, lead: @lead.attributes.except('id') }
        expect(department.leads.first.status).to eq('repeated')
      end

      it "redirects to leads_path" do
        department = create(:department)
        @lead.department_id = department.id
        post :create_delegated_lead, params: { id: @lead, lead: @lead.attributes.except('id') }
        expect(response).to redirect_to(leads_path)
      end

      it "shows flash[:notice] " do
        department = create(:department)
        @lead.department_id = department.id
        post :create_delegated_lead, params: { id: @lead, lead: @lead.attributes.except('id') }
        expect(flash[:notice]).to be_present
      end

      it 'creates notification' do
        department = create(:department)
        user2 = create(:user)
        create(:membership, user: user2, department: department, role: 'manager')
        @lead.department_id = department.id
        post :create_delegated_lead, params: { id: @lead, lead: @lead.attributes.except('id') }
        expect(user2.notifications.count).to be > 0
      end
    end
  end
end