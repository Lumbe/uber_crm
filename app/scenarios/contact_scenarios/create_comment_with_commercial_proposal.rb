module  ContactScenarios
  class CreateCommentWithCommercialProposal < ActionView::Base
    attr_accessor :commercial_proposal, :contact, :commercial_prop_url

    def initialize(commercial_proposal, contact, commercial_prop_url)
      @commercial_proposal = commercial_proposal
      @contact = contact
      @commercial_prop_url = commercial_prop_url
    end

    def perform
      contact.comments.create! user: commercial_proposal.user,
                               commentable: contact,
                               comment_type: 'commercial_prop',
                               body: "Отправлено почтой #{link_to commercial_proposal.project_name, commercial_prop_url}"
      contact.create_activity :send_proposal, owner: commercial_proposal.user, trackable_department_id: contact.department_id
    end
  end
end
