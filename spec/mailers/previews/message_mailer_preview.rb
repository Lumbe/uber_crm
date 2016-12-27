# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def send_mail
    MessageMailer.send_mail(Message.last, User.first)
  end
end
