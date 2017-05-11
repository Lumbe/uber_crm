require "rails_helper"

RSpec.describe CommercialProposalMailer, type: :mailer do

  describe 'Send lead information to email' do
    before :each do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @user = create(:user)
      @contact = create(:contact)
      @commercial_proposal = create(:commercial_proposal)
      CommercialProposalMailer.send_commercial_proposal(@contact, @user, @commercial_proposal).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to be > 0
    end

    it 'send with correct receiver email' do
      expect(ActionMailer::Base.deliveries.first.to[0]).to eq(@contact.email)
    end

    it 'send with correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Стоимость Вашего дома')
    end

    it 'send with correct sender email' do
      expect(ActionMailer::Base.deliveries.first.from[0]).to eq(@contact.department.email)
    end

    it 'send with correct user for mail observer' do
      expect(ActionMailer::Base.deliveries.first.observer_args[:user]).to eq(@user)
    end

    it 'send with correct lead for mail observer' do
      expect(ActionMailer::Base.deliveries.first.observer_args[:commercial_proposal]).to eq(@commercial_proposal)
    end
  end
end
