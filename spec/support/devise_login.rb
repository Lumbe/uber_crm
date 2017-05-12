module DeviseLogin

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      FactoryGirl.create(:membership, user: admin)
      sign_in admin
    end
  end

  def login_user(role)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      membership = FactoryGirl.create(:membership, user: user, role: role)
      user.update_attributes(current_department_id: membership.department.id, current_role: membership.role)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
