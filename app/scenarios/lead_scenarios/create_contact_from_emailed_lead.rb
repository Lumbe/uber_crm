module  LeadScenarios
  class CreateContactFromEmailedLead
    attr_accessor :lead

    def initialize(lead, user)
      @lead = lead
      @user = user
    end

    def perform
      if lead.related_contacts.present?
        lead.update contact: lead.related_contacts.first
      else
        attributes_for_contact = @lead.attributes.select { |key, _value| Lead.new.attributes.except('id', 'created_at', 'updated_at', 'status', 'contact_id').keys.include? key }
        contact = Contact.new(attributes_for_contact)
        lead.update(contact: contact)
        contact.update(assigned_to: @user.id)
        contact.sended!
        contact.save if contact.valid?
        contact.create_activity(:create, owner: @user, trackable_department_id: contact.department_id) if contact.persisted?
      end
    end
  end
end
