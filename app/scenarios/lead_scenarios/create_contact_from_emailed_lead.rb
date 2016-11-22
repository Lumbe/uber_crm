module  LeadScenarios
  class CreateContactFromEmailedLead
    attr_accessor :lead

    def initialize(lead, user)
      @lead = lead
      @user = user
    end

    def perform
      attributes_for_contact = @lead.attributes.select { |key, value| Lead.new.attributes.except('id', 'created_at', 'updated_at', 'status').keys.include? key }
      contact = Contact.new(attributes_for_contact)
      contact.update(assigned_to: @user.id)
      contact.sended!
      contact.save if contact.valid?
      contact.create_activity(:create, owner: @user, trackable_department_id: contact.department_id) if contact.persisted?
    end
  end
end