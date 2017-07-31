class HomeController < ApplicationController
  def index
    @templates =  Template.all
    @signatures = Signature.all
   	@contact = Contact.tagged_with(params[:flag]).where(params[:id],status: false).first
   	@previous_contact = @contact.next
		@next_contact =@contact.previous
		
    
  end
	def new
    @template =  Template.new
    @signatures = Signature.all
   	@contact = Contact.tagged_with(params[:flag]).where(status: false).first

  end
  
  
  def send_email
  	@template = Template.                                                                                             
    p @contact = Contact.where(status: false).first
    
    @signature = Signature.where(name: params[:email][:signature]).first
		p @contact.update(status: true)
    SignatureMailer.test_email(@contact.id, @signature.id,@template.id).deliver_now
		
    redirect_to root_path
 
  end
end
