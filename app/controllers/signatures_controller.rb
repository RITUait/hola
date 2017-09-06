class SignaturesController < ApplicationController
  def index
    @signatures = current_user.signatures
  end
  def new
    @signature = Signature.new
  end
  def create
    @user = current_user.id
    #byebug
    @signatures = current_user.signatures
    @signature = Signature.new(signature_params)
    @signature.user_id = current_user.id
    if current_user.signatures.empty?
      if @signature.save
        redirect_to root_path
      else
        render :new
      end
    else
      if @signature.save
        redirect_to signatures_path
      else
        render :new
      end
    end
  end
  def edit
    @signature = Signature.find(params[:id])
  end
  def destroy
    Signature.find(params[:id]).destroy
    redirect_to signatures_path
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
    params.require(:signature).permit(:name,:email,:smtp_mail_server,:api_key,:user_id)
  end

end
