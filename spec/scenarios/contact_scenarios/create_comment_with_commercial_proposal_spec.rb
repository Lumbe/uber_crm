require 'rails_helper'

RSpec.describe ContactScenarios::CreateCommentWithCommercialProposal do
  before :each do
    @commercial_proposal = create :commercial_proposal
    @contact = create :contact
    @commercial_prop_url = Faker::Internet.url
  end

  it 'initializes with given objects' do
    expect(ContactScenarios::CreateCommentWithCommercialProposal.new(@commercial_proposal, @contact, @commercial_prop_url).commercial_proposal).to eq(@commercial_proposal)
    expect(ContactScenarios::CreateCommentWithCommercialProposal.new(@commercial_proposal, @contact, @commercial_prop_url).contact).to eq(@contact)
    expect(ContactScenarios::CreateCommentWithCommercialProposal.new(@commercial_proposal, @contact, @commercial_prop_url).commercial_prop_url).to eq(@commercial_prop_url)
  end

  it 'creates comment for contact' do
    expect{ContactScenarios::CreateCommentWithCommercialProposal.new(@commercial_proposal, @contact, @commercial_prop_url).perform}
      .to change{@contact.comments.count}.by(1)
  end

  it 'creates activity for contact' do
    expect{ContactScenarios::CreateCommentWithCommercialProposal.new(@commercial_proposal, @contact, @commercial_prop_url).perform}
      .to change{PublicActivity::Activity.all.count}.by(1)
  end
end
