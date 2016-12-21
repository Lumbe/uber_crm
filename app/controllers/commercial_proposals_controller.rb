class CommercialProposalsController < ApplicationController
  def new
    @contact = Contact.find(params[:contact_id])
    @commercial_proposal = @contact.commercial_proposals.new
  end

  def create
    @contact = Contact.find(params[:contact_id])
    @commercial_proposal = @contact.commercial_proposals.new(commercial_proposal_params)
    if @commercial_proposal.save
      @commercial_proposal.create_activity :create, owner: current_user, trackable_department_id: @commercial_proposal.contact.department.id
      redirect_to contact_commercial_proposal_path(@contact, @commercial_proposal)
    else
      render 'new'
    end
  end

  def show
    @commercial_proposal = CommercialProposal.find(params[:id])
  end

  def send_by_email
    @commercial_proposal = CommercialProposal.find(params[:commercial_proposal_id])
    @contact = Contact.find(params[:contact_id])
    @user = current_user
    mail = CommercialProposalMailer.send_commercial_proposal(@contact, @user, @commercial_proposal)
    mail.deliver_later

    flash[:notice] = "Коммерческое предложение для #{@commercial_proposal.project_name} отправлено на почту: #{@contact.email}"

    redirect_back fallback_location: contact_commercial_proposal_path(@contact, @commercial_proposal)
  end

  private

  def commercial_proposal_params
    params.require(:commercial_proposal).permit(:project_name, :project_url, :house_kit_price, :additional_services_price,
                                                :contact_id, :user_id, :discount, :dollar_exchange_rate, :house_installation_price,
                                                :house_square)
  end
end
