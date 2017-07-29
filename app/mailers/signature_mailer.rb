class SignatureMailer < ApplicationMailer
  def test_email(contact_id, signature_id,template_id)
  	@contact = Contact.find(contact_id)
  	@signature = Signature.find(signature_id)
    @template = Template.find(template_id)
    options = { 
      :address => @signature.smtp_mail_server,
      :domain => @signature.domain,
      :port => @signature.port,
      :authentication => 'plain',
      :user_name => @signature.user_name,
      :password => @signature.password,
      :enable_starttls_auto => true 
    }
   
    mail(from: @signature.email, to: @contact.email, subject: 'Test Email',delivery_method_options: options)
    
  end  

end
