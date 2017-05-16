module ContactsHelper
  # translated statuses for select
  # @return [Array<Array>]
  def contact_statuses
    Contact.statuses.map do |status, _|
      [I18n.t("activerecord.attributes.contact.statuses.#{status}"), status]
    end
  end
end
