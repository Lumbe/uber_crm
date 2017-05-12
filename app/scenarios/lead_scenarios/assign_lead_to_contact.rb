module  LeadScenarios
  class AssignLeadToContact < ActionView::Base
    attr_accessor :lead, :contact, :lead_url

    def initialize(lead, contact, lead_url)
      @lead = lead
      @contact = contact
      @lead_url = lead_url
    end

    def perform
      lead.update(contact: contact)
      comment = contact.comments.create(user: lead.user, body: "Повторное обращение. Лид #{link_to lead.name, lead_url}", commentable: contact, comment_type: 'new_lead')
      contact.create_activity(:comment, owner: lead.user, trackable_department_id: contact.department_id) if comment.persisted?
    end
  end
end
