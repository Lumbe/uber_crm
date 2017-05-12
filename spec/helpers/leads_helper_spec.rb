require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LeadsHelper. For example:
#
# describe LeadsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe LeadsHelper, type: :helper do
  describe '#lead_statuses' do
    it 'returns two-dimensional array of translated and original lead statuses' do
      statuses = Lead.statuses.keys
      translated_statuses = I18n.t('activerecord.attributes.lead.statuses').values
      array_of_translated_statuses = translated_statuses.zip(statuses)

      expect(helper.lead_statuses).to eq(array_of_translated_statuses)
    end
  end
end
