# Preview all emails at http://localhost:3000/rails/mailers/commercial_proposal
class CommercialProposalPreview < ActionMailer::Preview
  def send_commercial_proposal
    CommercialProposalMailer.send_commercial_proposal(Contact.last, User.first, CommercialProposal.last)
  end
end
