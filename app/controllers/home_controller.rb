class HomeController < ApplicationController

  def index
    @activities = PublicActivity::Activity.where(trackable_department_id: current_user.departments.ids).order(created_at: :desc).first(100)
  end

end
