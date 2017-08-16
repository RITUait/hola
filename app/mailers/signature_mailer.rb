class SignatureMailer < ApplicationMailer
  def test_email(contact_id, signature_id, descriptions,paragraph,subject,greeting)
  	@descriptions = descriptions
  	@subject = subject
  	@greeting = greeting
  	@paragraph = paragraph
  	@contact = Contact.find(contact_id)
  	@signature = Signature.find(signature_id)
   # byebug
    options = { 
      :user_name => 'apikey',
      :address => @signature.smtp_mail_server,
      :domain => @signature.domain,
      :port => '587',
      :password => @signature.api_key,
      :authentication => 'plain',
      :enable_starttls_auto => true 
    }
    mail(from: @signature.email, to: @contact.email, subject: @subject,delivery_method_options: options)
    
  end  
  
  
end
