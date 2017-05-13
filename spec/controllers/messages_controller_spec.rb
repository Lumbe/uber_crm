require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET #index' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      3.times { create :message, user: @user, inbound: true }
      @messages = Message.all
    end

    it 'responds succesfully with an HTTP 200 status code' do
      get :index, params: { user_id: @user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index, params: { user_id: @user.id }
      expect(response).to render_template('index')
    end

    it 'populates @messages with correct data' do
      get :index, params: { user_id: @user.id }
      expect(assigns(:messages)).to match_array @messages
    end

    it 'populates @user' do
      get :index, params: { user_id: @user.id }
      expect(assigns(:user)).to eq @user
    end
  end

  describe 'GET #new' do
    login_user('manager')
    before :each do
      @user = subject.current_user
    end

    it 'assigns a new message to @message' do
      get :new, params: { user_id: @user.id }
      expect(assigns(:message)).to be_a_new(Message)
    end

    it 'renders the :new template' do
      get :new, params: { user_id: @user.id }
      expect(response).to render_template('new')
    end
  end

  describe 'GET #show' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      @message = create :message, user: @user
    end

    it 'assigns the requested message to @message' do
      get :show, params: { id: @message.id, user_id: @user.id }
      expect(assigns(:message)).to eq(@message)
    end

    it 'renders :show' do
      get :show, params: { id: @message.id, user_id: @user.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #commercial_proposals' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      commercial_proposal = create :commercial_proposal
      3.times { create :message, user: @user, inbound: false, commercial_proposal: commercial_proposal }
      @messages = Message.all
    end

    it 'responds succesfully with an HTTP 200 status code' do
      get :commercial_proposals, params: { user_id: @user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :commercial_proposals, params: { user_id: @user.id }
      expect(response).to render_template('commercial_proposals')
    end

    it 'populates @messages with correct data' do
      get :commercial_proposals, params: { user_id: @user.id }
      expect(assigns(:messages)).to match_array @messages
    end

    it 'populates @user' do
      get :commercial_proposals, params: { user_id: @user.id }
      expect(assigns(:user)).to eq @user
    end
  end

  describe 'GET #outbound' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      3.times { create :message, user: @user }
      @messages = Message.all
    end

    it 'responds succesfully with an HTTP 200 status code' do
      get :outbound, params: { user_id: @user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :outbound, params: { user_id: @user.id }
      expect(response).to render_template('outbound')
    end

    it 'populates @messages with correct data' do
      get :outbound, params: { user_id: @user.id }
      expect(assigns(:messages)).to match_array @messages
    end

    it 'populates @user' do
      get :outbound, params: { user_id: @user.id }
      expect(assigns(:user)).to eq @user
    end
  end

  describe 'POST #send_mail' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      clear_enqueued_jobs
    end

    context 'with valid attributes' do
      it 'saves new message to database' do
        post :send_mail, format: :js, params: { message: attributes_with_foreign_keys(:message), user_id: @user.id }
        expect(Message.count).to eq(1)
      end

      it 'responds succesfully with an HTTP 200 status code' do
        post :send_mail, format: :js, params: { message: attributes_with_foreign_keys(:message), user_id: @user.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'saves message with attachment if last is present' do
        @file = fixture_file_upload(Rails.root.join('spec', 'support', 'fixtures', 'image.jpg'))
        post :send_mail, format: :js, params: { message: attributes_with_foreign_keys(:message), user_id: @user.id, attachments_attributes: { attachment: [@file] } }
        expect(assigns(:message).attachments.count).to be > 0
      end

      it 'enque messages email job' do
        post :send_mail, format: :js, params: { message: attributes_with_foreign_keys(:message), user_id: @user.id }
        expect(enqueued_jobs.size).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it "don't save invalid message to database" do
        post :send_mail, format: :js, params: { message: attributes_for(:invalid_message), user_id: @user.id }
        expect(Message.count).to eq(0)
      end

      it 'shows alert message if invalid attachment present' do
        @file = fixture_file_upload(Rails.root.join('spec', 'support', 'fixtures', 'image.exe'))
        post :send_mail, format: :js, params: { message: attributes_with_foreign_keys(:message), user_id: @user.id, attachments_attributes: { attachment: [@file] } }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'POST #delivered' do
    before :each do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      admin = create :admin, current_role: 'admin'
      create :membership, user: admin
      user = create(:user)
      @message = create(:message)
      MessageMailer.send_mail(@message, user).deliver
      @message_id = ActionMailer::Base.deliveries.first.message_id
      @message.update message_id: @message_id
    end

    context 'with valid params' do
      it 'ensures user is authenticated' do
        post :delivered, params: { 'Message-Id'=>"<#{@message_id}>" }
        expect(subject.current_user).to be_present
      end

      it 'updates Message#delivered_at attribute on POST request' do
        post :delivered, params: { 'Message-Id'=>"<#{@message_id}>" }
        expect(Message.first.delivered_at).to_not be_nil
      end
    end

    context 'with invalid params' do
      it 'do not update Message#delivered_at attribute on POST request' do
        post :delivered, params: { 'Message-Id'=>"#{Faker::Internet.email}" }
        expect(Message.first.delivered_at).to be_nil
      end
    end
  end

  describe 'POST #delivered' do
    before :each do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      admin = create :admin, current_role: 'admin'
      create :membership, user: admin
      user = create(:user)
      @message = create(:message)
      MessageMailer.send_mail(@message, user).deliver
      @message_id = ActionMailer::Base.deliveries.first.message_id
      @message.update message_id: @message_id
    end

    context 'with valid params' do
      it 'ensures user is authenticated' do
        post :delivered, params: { 'message-id'=>"#{@message_id}" }
        expect(subject.current_user).to be_present
      end

      it 'updates Message#opened_at attribute on POST request' do
        post :opened, params: { 'message-id'=>"#{@message_id}" }
        expect(Message.first.opened_at).to_not be_nil
      end

      it 'creates notification on Message#opened_at POST request' do
        post :opened, params: { 'message-id'=>"#{@message_id}" }
        expect(Message.first.user.notifications.count).to be > 0
      end
    end

    context 'with invalid params' do
      it 'do not update Message#opened_at attribute on POST request' do
        post :opened, params: { 'message-id'=>"#{Faker::Internet.email}" }
        expect(Message.first.opened_at).to be_nil
      end

      it 'do not create notification on Message#opened_at POST request' do
        post :opened, params: { 'message-id'=>"#{Faker::Internet.email}" }
        expect(Message.first.user.notifications.count).to be 0
      end
    end
  end
end
