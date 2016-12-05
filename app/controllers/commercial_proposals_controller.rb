class CommercialProposalsController < ApplicationController
  def new
    @contact = Contact.find(params[:contact_id])
    @commercial_proposal = @contact.commercial_proposals.new
  end

  def create
    @contact = Contact.find(params[:contact_id])
    @commercial_proposal = @contact.commercial_proposals.new(commercial_proposal_params)
    if @commercial_proposal.save
      redirect_to contact_commercial_proposal_path(@contact, @commercial_proposal)
    else
      render 'new'
    end
  end

  def show
    @commercial_proposal = CommercialProposal.find(params[:id])
  end

  private

  def commercial_proposal_params
    params.require(:commercial_proposal).permit(:project_name, :project_url, :house_kit_price, :additional_services_price,
                                                :contact_id, :user_id, :discount, :dollar_exchange_rate)
  end
end
