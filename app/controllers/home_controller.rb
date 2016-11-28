class HomeController < ApplicationController

  def index
    @activities = PublicActivity::Activity.where(trackable_department_id: current_user.departments.ids).order(created_at: :desc).first(100)
    respond_to do |format|
      format.html
      format.json do
        @contacts = Contact.where(department: current_user.departments).top_repeated_leads
        # total_count = @contacts.count.count
        count = @contacts.count.count
        # @contacts = @contacts.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if (params[:iDisplayLength].to_i > 0)
        render json: {
          sEcho: params[:sEcho].to_i + 1,
          # iTotalRecords: total_count,
          iTotalDisplayRecords: count,
          aaData: @contacts.map do |contact|
            [
              view_context.link_to(contact.name, contact_path(contact)),
              contact.leads.count,
              contact.department.name
            ]
          end
        }
      end
    end
  end

end
