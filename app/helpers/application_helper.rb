module ApplicationHelper

    # helpers for Devise gem
    def resource_name
      :user
    end

    def resource
      @user ||= User.new
    end
    
    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
    
    # for current department object access in view
    def current_department
      Department.find(current_user.current_department_id)
    end

    def url_with_protocol(url)
      /^http/i.match(url) ? url : "http://#{url}"
    end

end
