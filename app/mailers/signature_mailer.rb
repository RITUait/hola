class SignatureMailer < ApplicationMailer
  def data(signature_id, descriptions,subject,greeting)
    @descriptions = descriptions
    @subject = subject
    @greeting = greeting
    @signature = Signature.find(signature_id)
  end
  def test_email(contact_id, signature_id, descriptions,subject,greeting)
    data(signature_id, descriptions,subject,greeting)
    @contact = Contact.find(contact_id)
     

    mail(from: @signature.email, to: @contact.email, subject: @subject,delivery_method_options: @signature.delivery_options)

  end

  def self_email(signature_id, descriptions,subject,greeting)
     data(signature_id, descriptions,subject,greeting)
     #byebug
    p @signature.smtp_mail_server
    mail(from: @signature.email, to: @signature.email, subject: @subject,delivery_method_options: options)

  end

end
