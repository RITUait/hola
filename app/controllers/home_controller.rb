class HomeController < ApplicationController

  def index
    @contact = Contact.new
    @signature = Signature.new
  end

  def new
    @signature = Signature.new
  end

  def create
    @signature = Signature.new(signature_params)
    @signature.user_id = current_user.id
    @signature.valid?
    if (@signature.valid? == false)
      render :index
    else
      @signature.save
    end
  end

  def contact
    @user = current_user.id
    @contacts = current_user.contacts   
    @contact = Contact.new(contact_params)
    @contact.save
  end

  def signature_params
    params.require(:signature).permit(:name,:email,:smtp_mail_server,:api_key,:user_id)
  end

  def contact_params
    params.require(:contact).permit(:name,:email,:company,:conference,:tag_list,:user_id)
  end

end
