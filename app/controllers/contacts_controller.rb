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
              view_context.link_to(contact.name, contact_path(contact)),
              contact.phone,
              contact.email,
              contact.region,
              "#{view_context.time_ago_in_words(contact.created_at)} назад",
              view_context.link_to("#{contact.assignee.first_name} #{contact.assignee.last_name}", user_path(contact.assignee))
            ]
          end
        }.to_json
      end
    end
  end

  def show
    @contact = Contact.find(params[:id])
    @user = @contact.user
    @commentable = @contact
    @comments = @commentable.comments.order(created_at: :asc)
    @comment = Comment.new
  end

  def new
    @contact = Contact.new
    @departments = current_user.departments
  end
  
  def create
    @contact = Contact.new(contact_params)
    @department = @contact.department
    if @contact.save
      # Create the notifications
      (@department.users.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "добавил", notifiable: @contact)
      end
      
      redirect_to @contact
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

  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :location,
                                 :project, :square, :floor, :question,
                                 :region, :source, :online_request,
                                 :come_in_office, :phone_call, :status,
                                 :user_id, :department_id, :assigned_to)
  end
  
  def load_contacts(paginate=true)
        # load contacts with filtered statuses and dates from datapicker
        contacts =  Contact.where(department: @user.current_department_id, created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).order(created_at: :desc)
        # total count for datatable view
        total_count = Contact.where(department: @user.current_department_id).count
        # count fo datatable view
        count = 
          if params[:sSearch].present? && params[:filtered_regions].present?
            contacts.where(region: params[:filtered_regions]).search(name_or_phone_or_email_cont: params[:sSearch]).result.count
          elsif params[:sSearch].present?
            contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result.count
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
        elsif params[:filtered_regions].present?
          [contacts.where(region: params[:filtered_regions]), count, total_count]
        else
          [contacts, count, total_count]
        end
        # [params[:sSearch].present? ? contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result : contacts, count, total_count]
        # [params[:filtered_regions].present? ? contacts.where(region: params[:filtered_regions]) : contacts, count, total_count]
  end
end
