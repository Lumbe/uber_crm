require 'rails_helper'

RSpec.describe LeadScenarios::CreateContactFromEmailedLead do
  before :each do
    @lead = create :lead
    @user = create :user
  end

  it 'initializes with given objects' do
    expect(LeadScenarios::CreateContactFromEmailedLead.new(@lead, @user).lead).to eq(@lead)
  end

  it 'assigns lead to contact if last is present' do
    LeadScenarios::CreateContactFromEmailedLead.new(@lead, @user).perform
    expect(@lead.contact).to be_present
  end

  it 'creates new contact from given lead' do
    expect{ LeadScenarios::CreateContactFromEmailedLead.new(@lead, @user).perform }.to change{ Contact.all.count }.by(1)
  end

  it "creates new contact from given lead with 'sended' status" do
    LeadScenarios::CreateContactFromEmailedLead.new(@lead, @user).perform
    expect(Contact.all.first.status).to eq ('sended')
  end

  it 'creates activity for assigned contact' do
    expect{ LeadScenarios::CreateContactFromEmailedLead.new(@lead, @user).perform }.to change{ PublicActivity::Activity.all.count }.by(1)
  end
end
