module Observers
  class MailObserver
    def self.delivered_email(message)
      return unless message.respond_to?(:observer_args)
      sent_email = Message.new(
         from: message.from.join(','),
         to: message.to.join(','),
         subject: message.subject,
         message_id: message.message_id,
         user_id: message.observer_args[:user].id,
         commercial_proposal_id: message.observer_args[:commercial_proposal].id
      )

      sent_email.body = if message.html_part.present? || message.text_part.present?
                           message.html_part.blank? ? message.text_part.body.raw_source : message.html_part.body.raw_source
                        else
                           message.body.raw_source
                        end

      # remove body styles to prevent breaking of existing layouts
      sent_email.body.to_s.sub!(/body style="([^"]*)"/, 'body')
      sent_email.body.to_s.sub!(/(<style).*(<\/style>)/, '')

      sent_email.save!
    end
  end
end