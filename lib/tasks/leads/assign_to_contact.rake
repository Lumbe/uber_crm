namespace :leads do
  desc 'Assign lead to related contact'
  task assign_to_contact: :environment do
    Lead.all.each do |lead|
      if lead.related_contacts.present?
        lead.update contact: lead.related_contacts.first
      end
    end
  end
end