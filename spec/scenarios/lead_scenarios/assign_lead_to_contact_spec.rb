require 'rails_helper'

RSpec.describe LeadScenarios::AssignLeadToContact do

  before :each do
    @lead = create :lead
    @contact = create :contact
    @lead_url = Faker::Internet.url
  end

  it 'initializes with given objects' do
    expect(LeadScenarios::AssignLeadToContact.new(@lead, @contact, @lead_url).lead).to eq(@lead)
    expect(LeadScenarios::AssignLeadToContact.new(@lead, @contact, @lead_url).contact).to eq(@contact)
    expect(LeadScenarios::AssignLeadToContact.new(@lead, @contact, @lead_url).lead_url).to eq(@lead_url)
  end

  it 'assigns lead to contact' do
    LeadScenarios::AssignLeadToContact.new(@lead, @contact, @lead_url).perform
    expect(@lead.contact).to eq @contact
  end

  it 'creates comment for assigned contact' do
    LeadScenarios::AssignLeadToContact.new(@lead, @contact, @lead_url).perform
    expect(@contact.comments.count).to be > 0
  end

  it 'creates activity for assigned contact' do
    expect{LeadScenarios::AssignLeadToContact.new(@lead, @contact, @lead_url).perform}.to change{PublicActivity::Activity.all.count}.by(1)
  end

end
