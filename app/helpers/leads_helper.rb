module LeadsHelper
  # translated statuses for select
  # @return [Array<Array>]
  def lead_statuses
    Lead.statuses.map do |status, _|
      [I18n.t("activerecord.attributes.lead.statuses.#{status}"), status]
    end
  end
end
