class UsersController < ApplicationController
  before_action :load_user
  before_action :load_memberships

  def index; end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'settings'
    end
  end

  def departments; end

  def settings; end

  def user_leads
    respond_to do |format|
      format.html
      format.json do
        @leads = Lead.where(assigned_to: @user.id)
        # total count for datatable view
        total_count = Lead.where(assigned_to: @user.id).count
        # count fo datatable view
        count = params[:sSearch].present? ? @leads.search(name_or_phone_or_email_cont: params[:sSearch]).result.count : @leads.count
        # paginate with kaminari gem
        @leads = @leads.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if params[:iDisplayLength].to_i > 0
        # search with ransack gem
        @leads = params[:sSearch].present? ? @leads.search(name_or_phone_or_email_cont: params[:sSearch]).result : @leads
        render json: {
          sEcho: params[:sEcho].to_i + 1,
          iTotalRecords: total_count,
          iTotalDisplayRecords: count,
          aaData: @leads.map do |lead|
            [
              case lead.status
              when 'newly' then (view_context.content_tag :span, 'Новый', class: 'label label-warning mb-5') +
                ' ' +
                (view_context.link_to '+ Взять в работу', claim_lead_path(lead), class: 'label label-flat text-success label-success')
              when 'repeated' then (view_context.content_tag :span, 'Повторно', class: 'label label-warning') +
                ' ' +
                (view_context.link_to '+ Взять в работу', claim_lead_path(lead), class: 'label label-flat text-success label-success')
              when 'closed' then view_context.content_tag :span, 'Закрыт', class: 'label label-default'
              when 'converted' then view_context.content_tag :span, 'Конвертирован', class: 'label label-success'
              when 'sended' then view_context.content_tag :span, 'Передан', class: 'label label-info'
              when 'claimed' then view_context.content_tag :span, 'В работе', class: 'label bg-orange'
              end,
              view_context.link_to(lead.name, lead_path(lead)),
              lead.phone,
              "#{view_context.time_ago_in_words(lead.created_at)} назад"
            ]
          end
        }.to_json
      end
    end
  end

  def user_contacts
    respond_to do |format|
      format.html
      format.json do
        @contacts = Contact.where(assigned_to: @user.id)
        # total count for datatable view
        total_count = Contact.where(assigned_to: @user.id).count
        # count fo datatable view
        count = params[:sSearch].present? ? @contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result.count : @contacts.count
        # paginate with kaminari gem
        @contacts = @contacts.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if params[:iDisplayLength].to_i > 0
        # search with ransack gem
        @contacts = params[:sSearch].present? ? @contacts.search(name_or_phone_or_email_cont: params[:sSearch]).result : @contacts
        render json: {
          sEcho: params[:sEcho].to_i + 1,
          iTotalRecords: total_count,
          iTotalDisplayRecords: count,
          aaData: @contacts.map do |contact|
            [
              view_context.link_to(contact.name, contact_path(contact)),
              contact.phone,
              contact.email,
              "#{view_context.time_ago_in_words(contact.created_at)} назад"
            ]
          end
        }.to_json
      end
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def load_memberships
    @memberships = @user.memberships.order(created_at: :asc)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar, :phone, :skype)
  end
end
