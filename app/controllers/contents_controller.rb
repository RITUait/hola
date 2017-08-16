class ContentsController < ApplicationController
  def index
    @templates =  Template.all
    @signatures = Signature.all 
    @signatures_map  = @signatures.map{|s| ["#{s.name} <#{s.email}>", s.email] }
   	@contacts = Contact.tagged_with(params[:context]).where(status: false)
    if @contacts.empty?
      flash[:notice] = "no contacts left"
      redirect_to dashboard_index_path
    end
   	
  end
	
	def send_email
  	@descriptions = params[:description]
  	@greeting	= params[:email][:greeting]
  	@subject = params[:email][:subject]
  	@paragraph = params[:email][:paragraph]                                                                       
    @contact = Contact.find(params[:email][:contact_id])
    @signature = Signature.find_by(email: params[:email][:signature])
    @contact.update(status: true)
    #byebug
    SignatureMailer.test_email(@contact.id, @signature.id, @descriptions,@paragraph,@subject,@greeting).deliver_now
    redirect_to (contents_path(:context => @contact.tag_list))
  end

  def self_email
    @descriptions = params[:description]
    @greeting = params[:email][:greeting]
    @subject = params[:email][:subject]
    @contact = Contact.find(params[:email][:contact_id])
    @paragraph = params[:email][:paragraph]                                                                      
    @signature = Signature.find_by(email: params[:email][:signature])
    #byebug
    SignatureMailer.test_email(@signature.id,@signature.id, @descriptions,@paragraph,@subject,@greeting).deliver_now
    respond_to do |format|
      format.js { 

      }
      format.html{
        flash[:alert] = "Email sent"
        redirect_to (contents_path(:context => @contact.tag_list))

      }
    end
    
  end

  
  def show
    @template = Template.find params[:id]

    respond_to do |format|
      format.json { render json: {"description" => @template.description}}
      #format.js { render layout: false, content_type: 'text/javascript'}
    end
		return
  end
end
