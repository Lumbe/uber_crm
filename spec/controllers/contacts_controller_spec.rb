require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

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

      it "populates @contacts" do
        user = subject.current_user
        contact = create(:contact, user: user, department_id: user.current_department_id)
        get :index, format: :json, params: { start: 60.days.ago, end: Time.zone.now }
        expect(assigns(:contacts)).to eq([contact])
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

    it "assigns the requested contact to @contact" do
      contact = create(:contact, department_id: subject.current_user.current_department_id)
      get :show, params: { id: contact.id }
      expect(assigns(:contact)).to eq(contact)
    end

    it "renders :show" do
      contact = create(:contact, department_id: subject.current_user.current_department_id)
      get :show, params: { id: contact.id }
      expect(response).to render_template('show')
    end
  end

  describe "GET #new" do
    login_user('manager')

    it "assigns a new contact to @contact" do
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    login_user("manager")

    context "with valid attributes" do
      it "saves new contact to database" do
        user = subject.current_user
        post :create, params: { contact: attributes_with_foreign_keys(:contact, user: user, department_id: user.current_department_id) }
        expect(Contact.count).to eq(1)
      end

      it "redirects to created contact" do
        user = subject.current_user
        post :create, params: { contact: attributes_with_foreign_keys(:contact, user: user, department_id: user.current_department_id) }
        expect(response).to redirect_to(contacts_path)
      end

      it 'creates notification' do
        user = subject.current_user
        user2 = create(:user)
        create(:membership, user: user2, department_id: user.current_department_id, role: 'manager')
        post :create, params: { contact: attributes_with_foreign_keys(:contact, user: user, department_id: user.current_department_id) }
        expect(user2.notifications.count).to be > 0
      end

    end

    context "with invalid attributes" do
      it "don't save invalid contact to database" do
        user = subject.current_user
        post :create, params: {contact: attributes_for(:invalid_contact, user: user, department_id: user.current_department_id) }
        expect(Contact.count).to eq(0)
      end

      it "redirects to the 'new' action" do
        user = subject.current_user
        post :create, params: {contact: attributes_for(:invalid_contact, user: user, department_id: user.current_department_id) }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    login_user('manager')
    before :each do
      @contact = create(:contact, name: "Lawrence", department_id: subject.current_user.current_department_id)
    end

    context 'valid attributes' do
      it 'locates the requested contact' do
        put :update, params: { id: @contact, contact: attributes_for(:contact) }
        expect(assigns(:contact)).to eq(@contact)
      end

      it 'changes contact attributes' do
        put :update, params: { id: @contact, contact: attributes_for(:contact, name: 'John') }
        @contact.reload
        expect(@contact.name).to eq('John')
      end

      it 'redirects to the updated contact' do
        put :update, params: { id: @contact, contact: attributes_for(:contact) }
        expect(response).to redirect_to(@contact)
      end
    end

    context 'invalid attributes' do
      it 'locates the requested contact' do
        put :update, params: { id: @contact, contact: attributes_for(:invalid_contact) }
        expect(assigns(:contact)).to eq(@contact)
      end

      it "does not change @contact's attributes"  do
        put :update, params: { id: @contact, contact: attributes_for(:contact, name: "")  }
        @contact.reload
        expect(@contact.name).not_to eq('')
      end

      it "re-renders edit" do
        put :update, params: { id: @contact, contact: attributes_for(:invalid_contact) }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE' do
    context 'admin' do
      login_admin
      before :each do
        @contact = create(:contact, name: "Lawrence", department_id: subject.current_user.current_department_id)
      end

      it 'destroys contact' do
        expect { delete :destroy, params: {id: @contact} }.to change{Contact.count}.by(-1)
      end

      it 'redirects to index contacts' do
        delete :destroy, params: { id: @contact }
        expect(response).to redirect_to(contacts_path)
      end
    end

    context 'user' do
      login_user('manager')
      before :each do
        @contact = create(:contact, name: "Lawrence", department_id: subject.current_user.current_department_id)
      end

      it 'do not destroys contact' do
        expect { delete :destroy, params: {id: @contact} }.to_not change(Contact, :count)
      end

      it 'redirects to unauthorized' do
        delete :destroy, params: { id: @contact }
        expect(response).to redirect_to('/unauthorized')
      end
    end

  end



end
