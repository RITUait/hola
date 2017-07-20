class SignatureMailer < ApplicationMailer
  def test_email(contact_id, signature_id)
  	@contact = Contact.find(contact_id)
  	@signature = Signature.find(signature_id)
    options = { 
      :address => @signature.smtp_mail_server,
      :domain => "joshsoftware.com",
      :port => @signature.port,
      :authentication => 'plain',
      :user_name => @signature.user_name,
      :password => @signature.password,
      :enable_starttls_auto => true 
    }
    Mail.defaults do
      delivery_method :smtp, options
    end

    mail = Mail.new(from: @signature.email, to: @contact.email, subject: 'Test Email')
    mail.deliver!
  end  

end
