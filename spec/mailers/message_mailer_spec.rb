require 'rails_helper'

RSpec.describe MessageMailer, type: :mailer do
  describe 'Send message' do
    before :each do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @user = create(:user)
      @message = create(:message)
      MessageMailer.send_mail(@message, @user).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to be > 0
    end

    it 'send with correct receiver email' do
      expect(ActionMailer::Base.deliveries.first.to[0]).to eq(@message.to)
    end

    it 'send with correct default subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('(Без темы)')
    end

    it 'send with custom subject' do
      user = create(:user)
      message = create(:message, subject: 'Правки к макету')
      MessageMailer.send_mail(message, user).deliver
      expect(ActionMailer::Base.deliveries.last.subject).to eq(message.subject)
    end

    it 'send with correct sender email' do
      expect(ActionMailer::Base.deliveries.first.from[0]).to eq('office@servus.km.ua')
    end

    it 'send with correct user for mail observer' do
      expect(ActionMailer::Base.deliveries.first.observer_args[:user]).to eq(@user)
    end

    it 'send with correct lead for mail observer' do
      expect(ActionMailer::Base.deliveries.first.observer_args[:message]).to eq(@message)
    end

    it 'send with attachment' do
      user = create(:user)
      message = create(:message)
      create :attachment, message: message
      MessageMailer.send_mail(message, user).deliver
      expect(ActionMailer::Base.deliveries.last.attachments).to be_present
    end
  end
end
