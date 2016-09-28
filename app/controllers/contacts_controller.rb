class ContactsController < ApplicationController

  def index
    @user = current_user
    if !@user.departments.any?
      flash[:alert] = "У Вас нет доступа ни к одному отделу. Запросите доступ у администратора"
    end
    respond_to do |format|
      format.html
      format.json do
                # load contacts with filtered statuses and dates from datapicker
        @contacts =  if params[:department].present?
                    Contact.where(department: params[:department], created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).order(created_at: :desc)
                  elsif @user.departments.any?
                    Contact.where(department: current_user.departments.first, created_at: Time.zone.parse(params[:start])..Time.zone.parse(params[:end])).order(created_at: :desc)
                  end
        # total count for datatable view
        total_count = if params[:department].present?
                        Contact.where(department: params[:department]).count
                      elsif @user.departments.present?
                        Contact.where(department: @user.departments.first).count
                      end
        # count fo datatable view
        count = params[:sSearch].present? ? @contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result.count : @contacts.count
        # paginate with kaminari gem
        @contacts = @contacts.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if params[:iDisplayLength].to_i > 0
        # search with ransack gem
        @contacts = params[:sSearch].present? ? @contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result : @contacts
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
              contact.location,
              "#{view_context.time_ago_in_words(contact.created_at)} назад",
              view_context.content_tag(:ul, class: 'icons-list') do
                view_context.content_tag(:li, class: 'dropdown') do
                  view_context.link_to('#', class: 'dropdown-toggle', data: {toggle: 'dropdown'}) do
                    view_context.content_tag(:i, '', class: 'icon-menu9')
                  end +
                  view_context.content_tag(:ul, class: 'dropdown-menu dropdown-menu-right') do
                    view_context.content_tag(:li) do
                      view_context.link_to('#') do
                        view_context.content_tag(:i, '', class: 'icon-spinner11') + 'Конвертировать'
                      end
                    end +
                    view_context.content_tag(:li) do
                      view_context.link_to('#') do
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
    @contact = Contact.find(params[:id])
    @user = @contact.user
    @commentable = @contact
    @comments = @commentable.comments
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
end
