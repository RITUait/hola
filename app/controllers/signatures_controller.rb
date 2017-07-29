class SignaturesController < ApplicationController
  def index
    @signature = Signature.all
  end
  def new
    @signature = Signature.new
  end
  def create
    @signature = Signature.new(signature_params)
    if @signature.save
        redirect_to signatures_path
    else
        render :new
    end
  end
  def update
    @signature = Signature.find(params[:id])
    if @signature.update_attributes(signature_params)
      redirect_to signatures_path
    else
      render :new
    end 
  end
  def preview
    SignatureMailer.test_email(@contact.id, @signature.id)
  end
  
    def signature_params
      params.require(:signature).permit(:name,:email,:address,:password,:port,:user_name,:smtp_mail_server,:domain)
    end
     
end
