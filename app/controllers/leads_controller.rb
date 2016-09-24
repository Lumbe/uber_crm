class LeadsController < ApplicationController
  before_filter :load_statuses, only: :new

  def index
    @user = current_user
    if !@user.departments.any?
      flash[:alert] = "У Вас нет доступа ни к одному отделу. Запросите доступ у администратора"
    end
    respond_to do |format|
      format.html
      format.json do
                # load leads with filtered statuses and dates from datapicker
        @leads =  if params[:department].present?
                    Lead.where(status: params[:statuses], department: params[:department], created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).order(created_at: :desc)
                  elsif @user.departments.any?
                    Lead.where(status: params[:statuses], department: current_user.departments.first, created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).order(created_at: :desc)
                  end
        # total count for datatable view
        total_count = Lead.all.count
        # count fo datatable view
        count = params[:sSearch].present? ? @leads.search(name_or_phone_or_email_cont: params[:sSearch]).result.count : @leads.count
        # paginate with kaminari gem
        @leads = @leads.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if params[:iDisplayLength].to_i > 0
        # search with ransack gem
        @leads = params[:sSearch].present? ? @leads.search(name_or_phone_or_email_cont: params[:sSearch]).result : @leads
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
              when 'sended' then view_context.content_tag :span, 'Передан в ГО', class: 'label label-info'
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
                      view_context.link_to('#') do
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
  end
  
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to @lead
    else
      render 'new'
    end
  end
  
  def edit
    @lead = Lead.find(params[:id])
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
    @lead.closed!
    
    redirect_to :back
  end
  
  def convert
    @lead = Lead.find(params[:id])
    @lead.converted!
    contact_attributes = Lead.find(params[:id]).attributes.select { |key, value| Contact.new.attributes.except("id", "created_at", "updated_at").keys.include? key }
    contact_attributes["user_id"] ||= current_user.id
    contact_attributes["assigned_to"] ||= current_user.id
    @contact = Contact.new(contact_attributes)
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
    @statuses = Lead.statuses.keys
  end
end
