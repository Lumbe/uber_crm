class LeadsController < ApplicationController
  before_action :load_statuses, only: [:new, :edit, :create]
  load_and_authorize_resource except: [:new]

  def index
    @user = current_user
    if !@user.departments.any?
      flash[:alert] = "У Вас нет доступа ни к одному отделу. Запросите доступ у администратора"
    end
    respond_to do |format|
      format.html
      format.xlsx do
        @leads = load_leads(false).first
      end
      format.json do
        @leads, count, total_count = load_leads
        # render json on ajax request
        render json: {
          sEcho: params[:sEcho].to_i + 1,
          iTotalRecords: total_count,
          iTotalDisplayRecords: count,
          aaData: @leads.map do |lead| 
            [
              case lead.status
              when 'newly' then  (view_context.content_tag :span, 'Новый', class: 'label label-warning mb-5') +
                " " +
                (view_context.link_to '+ Взять в работу', claim_lead_path(lead), class: 'label label-flat text-success label-success')
              when 'repeated' then (view_context.content_tag :span, 'Повторно', class: 'label label-warning') +
                " " +
                (view_context.link_to '+ Взять в работу', claim_lead_path(lead), class: 'label label-flat text-success label-success')
              when 'closed' then view_context.content_tag :span, 'Закрыт', class: 'label label-default'
              when 'converted' then view_context.content_tag :span, 'Конвертирован', class: 'label label-success'
              when 'sended' then view_context.content_tag :span, 'Передан', class: 'label label-info'
              when 'claimed' then view_context.content_tag :span, 'В работе', class: 'label bg-orange'
              end,
              view_context.link_to(lead.name, lead_path(lead)),
              lead.phone,
              lead.email,
              lead.location,
              "#{view_context.time_ago_in_words(lead.created_at)} назад",
              view_context.content_tag(:ul, class: 'icons-list') do
                view_context.content_tag(:li, class: 'dropdown') do
                  view_context.link_to('#', class: 'dropdown-toggle', data: {toggle: 'dropdown'}) do
                    view_context.content_tag(:i, '', class: 'icon-menu9')
                  end +
                  view_context.content_tag(:ul, class: 'dropdown-menu dropdown-menu-right') do
                    view_context.content_tag(:li) do
                      view_context.link_to(convert_lead_path(lead.id)) do
                        view_context.content_tag(:i, '', class: 'icon-spinner11') + 'Конвертировать'
                      end
                    end +
                    view_context.content_tag(:li) do
                      view_context.link_to(close_lead_path(lead.id)) do
                        view_context.content_tag(:i, '', class: 'icon-cross2') + 'Закрыть'
                      end
                    end +
                    view_context.content_tag(:li) do
                      view_context.link_to(delegate_lead_path(lead.id)) do
                        view_context.content_tag(:i, '', class: 'icon-users2') + 'Делегировать'
                      end
                    end +
                    view_context.content_tag(:li) do
                      view_context.link_to('#') do
                        view_context.content_tag(:i, '', class: 'icon-envelope') + 'Отправить почтой'
                      end
                    end
                  end 
                end
              end.html_safe
            ]
          end
        }.to_json
      end
    end
  end

  def show
    @lead = Lead.find(params[:id])
    @user = @lead.user
  end

  def new
    @lead = Lead.new
    @departments = current_user.departments
  end
  
  def create
    @lead = Lead.new(lead_params)
    @lead.repeated! if @lead.contact_exists?
    @department = @lead.department
    if @lead.save
      # Create the notifications
      (@department.users.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "добавил", notifiable: @lead)
      end
      
      flash[:notice] = "Лид #{@lead.name} успешно передан в отдел: #{@lead.department.name}" if @lead.source == "Передали"
      redirect_to leads_path
    else
      render 'new'
    end
  end
  
  def edit
    @lead = Lead.find(params[:id])
    @departments = current_user.departments
  end

  def update
    @lead = Lead.find(params[:id])

    if @lead.update(lead_params)
      redirect_to @lead
    else
      render 'edit'
    end
  end

  def destroy
    @lead = Lead.find(params[:id])
    @lead.destroy

    redirect_to leads_path
  end
  
  def claim
    @lead = Lead.find(params[:id])
    @user = current_user
    @lead.claimed!
    @lead.update(assignee: @user)
    
    redirect_to :back
  end
  
  def close
    @lead = Lead.find(params[:id])
    @user = current_user
    @lead.closed!
    @lead.assigned_to = @user.id
    @lead.save
    
    redirect_to :back
  end
  
  def convert
    @lead = Lead.find(params[:id])
    @lead.converted!
    @departments = current_user.departments
    contact_attributes = Lead.find(params[:id]).attributes.select { |key, value| Contact.new.attributes.except('id', 'created_at', 'updated_at', 'status').keys.include? key }
    contact_attributes['user_id'] ||= current_user.id
    contact_attributes['assigned_to'] ||= current_user.id
    @contact = Contact.new(contact_attributes)
  end
  
  def delegate
    @lead = Lead.find(params[:id])
    @lead.sended!
    @departments = Department.all.collect {|department| [ department.name, department.id ] }
    lead_attributes = Lead.find(params[:id]).attributes.select { |key, value| Lead.new.attributes.except('id', 'created_at', 'updated_at', 'status').keys.include? key }
    lead_attributes['user_id'] = current_user.id
    lead_attributes['status'] = 'newly'
    lead_attributes['department_id'] = params[:department_id]
    @lead = Lead.new(lead_attributes)
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :phone, :email, :location,
                                 :project, :square, :floor, :question,
                                 :region, :source, :online_request,
                                 :come_in_office, :phone_call, :status,
                                 :user_id, :department_id, :assigned_to)
  end
  
  def load_statuses
    @statuses = Lead.status_attributes_for_select
  end
  
  def load_leads(paginate=true)
    # load leads with filtered statuses and dates from datapicker
    leads = Lead.where(status: params[:statuses], department_id: @user.current_department_id, created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).order_by_status.order(created_at: :desc)
    total_count = Lead.where(department_id: @user.current_department_id).count
    # count fo datatable view
    count = params[:sSearch].present? ? leads.search(name_or_phone_or_email_cont: params[:sSearch]).result.count : leads.count
    # paginate with kaminari gem
    leads = leads.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if paginate && (params[:iDisplayLength].to_i > 0)
    # search with ransack gem
    [params[:sSearch].present? ? leads.search(name_or_phone_or_email_cont: params[:sSearch]).result : leads, count, total_count]
  end
end
