class LeadsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json do
        @filtered_statuses = params[:statuses]
        # load leads with filtered statuses
        @leads = Lead.where("status IN (?)", @filtered_statuses).order(created_at: :desc)
        # total count for datatable view
        total_count = @leads.count
        # count fo datatable view
        count = params[:sSearch].present? ? @leads.search(name_or_email_cont: params[:sSearch]).result.count : @leads.count
        # paginate with kaminari gem
        @leads = @leads.page(params[:iDisplayStart].to_i / params[:iDisplayLength].to_i + 1).per(params[:iDisplayLength].to_i) if params[:iDisplayLength].to_i > 0
        # search with ransack gem
        @leads = params[:sSearch].present? ? @leads.search(name_or_email_cont: params[:sSearch]).result : @leads
        # render json on ajax request
        render json: {
          sEcho: params[:sEcho].to_i + 1,
          iTotalRecords: total_count,
          iTotalDisplayRecords: count,
          aaData: @leads.map do |lead| 
            [
              case lead.status
              when 'newly' then view_context.content_tag :span, 'Новый', class: 'label label-warning'
              when 'repeated' then view_context.content_tag :span, 'Повторно', class: 'label label-warning'
              when 'closed' then view_context.content_tag :span, 'Закрыт', class: 'label label-default'
              when 'converted' then view_context.content_tag :span, 'Конвертирован', class: 'label label-success'
              when 'sended' then view_context.content_tag :span, 'Передан в ГО', class: 'label label-info'
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
    @lead = Lead.find(params[:id])
  end

  def new
    @lead = Lead.new
  end

  def edit
    @lead = Lead.find(params[:id])
  end

  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to @lead
    else
      render 'new'
    end
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

  private

  def lead_params
    params.require(:lead).permit(:name, :phone, :email, :location,
                                 :project, :square, :floor, :question,
                                 :region, :source, :online_request,
                                 :come_in_office, :phone_call, :status)
  end
end
