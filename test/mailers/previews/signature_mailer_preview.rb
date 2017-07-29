# Preview all emails at http://localhost:3000/rails/mailers/signature_mailer
class SignatureMailerPreview < ActionMailer::Preview
	def test_email
	@contact = Contact.first
	@signature = Signature.first
	SignatureMailer.test_email(@contact.id, @signature.id)
	end
end
