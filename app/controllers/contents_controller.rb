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
    @contacts = Contact.tagged_with(params[:context]).where(status: false)
    @signature = Signature.find_by(email: params[:email][:signature])
    @contact.update(status: true)
    
    SignatureMailer.test_email(@contact.id, @signature.id, @descriptions,@paragraph,@subject,@greeting)
    respond_to do |format|
      format.json { 
        #@contact = Contact.find(params[:email][:contact_id])
        #byebug
        render json: {contacts: @contacts}, status: :ok
        flash[:alert] = "Email sent"
        #redirect_to (contents_path(:context => @contact.tag_list))             
      }
      format.html{
      }
    end

  end

  def self_email
    @descriptions = params[:description]
    @greeting = params[:email][:greeting]
    @subject = params[:email][:subject]
    @contact = Contact.find(params[:email][:contact_id])
    @paragraph = params[:email][:paragraph]
    @signature = Signature.find_by(email: params[:email][:signature])
    
    SignatureMailer.self_email(@signature.id, @descriptions,@paragraph,@subject,@greeting).deliver_now
    respond_to do |format|
      #byebug
      format.js {
        @contact = Contact.find(params[:email][:contact_id])
        flash[:alert] = "Email sent"
      }
      format.html{

        #redirect_to (contents_path(:context => @contact.tag_list))

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
