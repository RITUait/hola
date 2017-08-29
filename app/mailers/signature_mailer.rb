class SignatureMailer < ApplicationMailer
  def test_email(contact_id, signature_id, descriptions,paragraph,subject,greeting)
    @descriptions = descriptions
    @subject = subject
    @greeting = greeting
    @paragraph = paragraph
    @contact = Contact.find(contact_id)
    @signature = Signature.find(signature_id)
    if (@signature.domain=="joshsoftware.com") then
    options = {
      :user_name => 'apikey',
      :address => @signature.smtp_mail_server,
      :domain => @signature.domain,
      :port => '587',
      :password => @signature.api_key,
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
  else
    options = {
      :user_name => @signature.api_key,
      :address => @signature.smtp_mail_server,
      :domain => @signature.domain,
      :port => '587',
      :password => @signature.api_key,
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
  end
    mail(from: @signature.email, to: @contact.email, subject: @subject,delivery_method_options: options)

  end

  def self_email(signature_id, descriptions,paragraph,subject,greeting)
    @descriptions = descriptions
    @subject = subject
    @greeting = greeting
    @paragraph = paragraph
    @signature = Signature.find(signature_id)
     #byebug
    if (@signature.domain=="joshsoftware.com") then
    options = {
      :user_name => 'apikey',
      :address => @signature.smtp_mail_server,
      :domain => @signature.domain,
      :port => '587',
      :password => @signature.api_key,
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
    else
    options = {
      :user_name => @signature.api_key,
      :address => @signature.smtp_mail_server,
      :domain => @signature.domain,
      :port => '587',
      :password => @signature.api_key,
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
  end
    mail(from: @signature.email, to: @signature.email, subject: @subject,delivery_method_options: options)

  end

end
