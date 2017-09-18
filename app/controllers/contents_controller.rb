class ContentsController < ApplicationController
  def index
    @templates =  current_user.templates
    @template = current_user.templates
    @signatures = current_user.signatures 
    @signatures_map  = @signatures.map{|s| ["#{s.name} <#{s.email}>", s.email] }
    @contacts = current_user.contacts.tagged_with(params[:context]).where(status: false)
    if @contacts.empty?
      @contacts
      flash[:notice] = "no contacts left"
      redirect_to dashboard_index_path
    end

  end

  def send_email
    @descriptions = params[:description]
    @greeting	= params[:email][:greeting]
    @subject = params[:email][:subject]
    @paragraph = params[:email][:paragraph]
    @contact = current_user.contacts.find(params[:email][:contact_id])

    @signature = Signature.find_by(email: params[:email][:signature])


    #byebug
    print "signature mail"
    SignatureMailer.test_email(@contact.id, @signature.id, @descriptions,@paragraph,@subject,@greeting).deliver_now
    print "delivery mails"
    @contact.update(status: true)
    @contacts = current_user.contacts.tagged_with(params[:context]).where(status: false)
    flash[:alert] = "Email sent"
    @contacts
    respond_to do |format|
      format.json { 
        #@contact = Contact.find(params[:email][:contact_id])
        #byebug
        @contacts
        render json: {contacts: @contacts}, status: :ok


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
        flash[:notice] = "Email sent"
        @contact = Contact.find(params[:email][:contact_id])
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
