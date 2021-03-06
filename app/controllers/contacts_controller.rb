class ContactsController < ApplicationController
  load_and_authorize_resource except: [:new]
  
  def index
    @user = current_user
    if !@user.departments.any?
      flash[:alert] = "У Вас нет доступа ни к одному отделу. Запросите доступ у администратора"
    end
    respond_to do |format|
      format.html
      format.xlsx do
        @contacts = load_contacts(false).first
      end
      format.json do
        @contacts, count, total_count = load_contacts
        # render json on ajax request
        render json: {
          sEcho: params[:sEcho].to_i + 1,
          iTotalRecords: total_count,
          iTotalDisplayRecords: count,
          aaData: @contacts.map do |contact| 
            [
              case contact.status
              when 'newly' then  (view_context.content_tag :span, 'Новый', class: 'label label-warning mb-5')
              when 'repeated' then (view_context.content_tag :span, 'Повторно', class: 'label label-warning mb-5')
              when 'proposal' then (view_context.content_tag :span, 'Отправлено КП', class: 'label label-info mb-5') +
                if contact.commercial_proposals.present? && contact.commercial_proposals.last.messages.present? && !contact.commercial_proposals.last.messages.last.delivered_at.blank?
                  if ( Time.zone.now.to_i - contact.commercial_proposals.last.messages.last.delivered_at.to_i) > 86400
                    (view_context.content_tag :div, "#{view_context.time_ago_in_words(contact.proposal_sent)} назад", class: 'text-bold text-danger')
                  else
                    (view_context.content_tag :div, "#{view_context.time_ago_in_words(contact.proposal_sent)} назад")
                  end
                end
              when 'finished' then view_context.content_tag :span, 'Завершено', class: 'label label-default'
              when 'sended' then view_context.content_tag :span, 'Передан', class: 'label label-info'
              end,
              view_context.link_to(contact.name, contact_path(contact)),
              if contact.do_not_call?
                view_context.content_tag :span, contact.phone, class: 'text-danger'
              else
                contact.phone
              end, 
              if contact.do_not_call?
                view_context.content_tag :span, contact.email, class: 'text-danger'
              else
                contact.email
              end,
              contact.region,
              "#{view_context.time_ago_in_words(contact.created_at)} назад",
              view_context.link_to("#{contact.assignee.first_name} #{contact.assignee.last_name}", user_path(contact.assignee))
            ]
          end
        }
      end
    end
  end

  def show
    @contact = Contact.find(params[:id])
    @user = current_user
    @message = Message.new
    @commentable = @contact
    @comments = @commentable.comments.order(created_at: :asc)
    @comment = Comment.new
    gon.push({
      contact_email: @contact.email
    })
  end

  def new
    @contact = Contact.new
    @departments = current_user.departments.uniq
  end
  
  def create
    @contact = Contact.new(contact_params)
    @department = @contact.department
    if @contact.save
      # Create the notifications
      (@department.users.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "добавил", notifiable: @contact)
      end
      
      if session[:converted_lead_id].present?
        converted_lead = Lead.find_by(id: session[:converted_lead_id])
        converted_lead.converted!
        converted_lead.create_activity :convert, owner: current_user, trackable_department_id: converted_lead.department_id
        session[:converted_lead_id] = nil
      end
      @contact.create_activity :create, owner: current_user, trackable_department_id: @contact.department_id

      redirect_to contacts_path
    else
      render 'new'
    end
  end
  
  def edit
    @contact = Contact.find(params[:id])
    @departments = current_user.departments
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      redirect_to @contact
    else
      render 'edit'
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to contacts_path
  end
  
  def change_status
    contact = Contact.find(params[:id])
    case params[:contact_status]
    when 'newly'
      contact.newly!
      redirect_to contact
    when 'repeated'
      contact.repeated!
      redirect_to contact
    when 'proposal'
      contact.proposal!
      redirect_to contact
    when 'finished'
      contact.finished!
      redirect_to contact
    when 'sended'
      contact.sended!
      redirect_to contact
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :location,
                                 :project, :square, :floor, :question,
                                 :region, :source, :online_request,
                                 :come_in_office, :phone_call, :status,
                                 :user_id, :department_id, :assigned_to,
                                 :alt_email, :do_not_call)
  end

  def load_contacts(paginate=true)
    # load contacts with filtered statuses and dates from datapicker
    contacts =  Contact.where(department: @user.current_department_id).order_by_status.order(created_at: :desc)
    # total count for datatable view
    total_count = Contact.where(department: @user.current_department_id).count
    # count fo datatable view
    count =
      if params[:sSearch].present? && params[:filtered_regions].present?
        contacts.where(region: params[:filtered_regions]).search(name_or_phone_or_email_cont: params[:sSearch]).result.count
      elsif params[:sSearch].present?
        contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result.count
      elsif params[:start].present? && params[:end].present? && params[:filtered_regions].present?
        contacts.where(created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end]), region: params[:filtered_regions]).count
      elsif params[:start].present? && params[:end].present?
        contacts.where(created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).count
      elsif params[:filtered_regions].present?
        contacts.where(region: params[:filtered_regions]).count
      else
        contacts.count
      end
    # paginate with kaminari gem
    contacts = contacts.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if paginate && params[:iDisplayLength].to_i > 0
    # search with ransack gem
    if params[:sSearch].present? && params[:filtered_regions].present?
      [contacts.where(region: params[:filtered_regions]).search(name_or_phone_or_email_cont: params[:sSearch]).result, count, total_count]
    elsif params[:sSearch].present?
      [contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result, count, total_count]
    elsif params[:start].present? && params[:end].present? && params[:filtered_regions].present?
      [contacts.where(created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end]), region: params[:filtered_regions]), count, total_count]
    elsif params[:start].present? && params[:end].present?
      [contacts.where(created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])), count, total_count]
    elsif params[:filtered_regions].present?
      [contacts.where(region: params[:filtered_regions]), count, total_count]
    else
      [contacts, count, total_count]
    end
  end
end
