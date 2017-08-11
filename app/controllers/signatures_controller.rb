class SignaturesController < ApplicationController    
  def index
    @signature = Signature.all
  end
  def new
    @signature = Signature.new(name: 'sam')
  end
  def create
    @signature = Signature.new(signature_params)
    if @signature.save
        redirect_to dashboard_index_path
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
  
  def signature_params
    params.require(:signature).permit(:name,:email,:smtp_mail_server,:api_key,:domain)
  end
     
end
