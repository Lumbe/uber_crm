require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ContactsHelper. For example:
#
# describe ContactsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ContactsHelper, type: :helper do

  describe "#contact_statuses" do
    it 'returns two-dimensional array of translated and original contact statuses' do
      statuses = Contact.statuses.keys
      translated_statuses = I18n.t("activerecord.attributes.contact.statuses").values
      array_of_translated_statuses = translated_statuses.zip(statuses)

      expect(helper.contact_statuses).to eq(array_of_translated_statuses)
    end
  end
end
