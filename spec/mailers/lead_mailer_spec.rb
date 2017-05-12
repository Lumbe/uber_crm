require 'rails_helper'

RSpec.describe LeadMailer, type: :mailer do

  describe 'Send lead information to email' do
    before :each do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @user = create(:user)
      @lead = create(:lead)
      @email = Faker::Internet.email
      LeadMailer.send_lead(@email, @user, @lead ).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to be > 0
    end

    it 'send with correct receiver email' do
      expect(ActionMailer::Base.deliveries.first.to[0]).to eq(@email)
    end

    it 'send with correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Новый лид')
    end

    it 'send with correct sender email' do
      expect(ActionMailer::Base.deliveries.first.from[0]).to eq(@lead.department.email)
    end

    it 'send with correct user for mail observer' do
      expect(ActionMailer::Base.deliveries.first.observer_args[:user]).to eq(@user)
    end

    it 'send with correct lead for mail observer' do
      expect(ActionMailer::Base.deliveries.first.observer_args[:lead]).to eq(@lead)
    end
  end

end
