require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe 'comments create on Contact#send_proposal' do
    login_user('manager')
    before :each do
      @user = subject.current_user
      @commentable = create(:contact, department_id: @user.current_department_id)
    end
    it 'creates new comment on contact proposal sent' do
      post :create, params: { contact_id: @commentable.id, comment: attributes_for(:comment, comment_type: 'commercial_prop') }
      expect(@commentable.comments.count).to be > 0
    end
    
    it 'evaluates proper comment_type' do
      post :create, params: { contact_id: @commentable.id, comment: attributes_with_foreign_keys(:comment, user: @user, comment_type: 'commercial_prop') }
      expect(assigns(:comment).comment_type).to eq('commercial_prop')
    end
    
    it 'changes contact status' do
      post :create, params: { contact_id: @commentable.id, comment: attributes_with_foreign_keys(:comment, user: @user, comment_type: 'commercial_prop') }
      expect(assigns(:commentable).status).to eq('proposal')
    end
  end
end
