
class ContactsController < ApplicationController
  def index
    p @contacts = current_user.contacts.paginate(page: params[:page], per_page: 10)
   
  end

  def import
    Contact.import(params[:file], current_user.id)
    redirect_to contacts_path, notice: "contacts imported."
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = current_user.id
    @contacts = current_user.contacts   
    @contact = Contact.new(contact_params)
    p @contact.user_id = current_user.id
    p @contacts = current_user.contacts
    p tag = @contact.tag_list
    p contact = Contact.find_or_create_by(email: @contact.email)
    if contact.persisted?
      contact.tag_list.add(tag)
      contact.save
      redirect_to contacts_path
    else
      @contact.save
      redirect_to contacts_path
    end
  end
  def edit
    @contact = Contact.find(params[:id])
  end
  def destroy
    Contact.find(params[:id]).destroy
    redirect_to contacts_path
  end
  def update
    @contact= Contact.find(params[:id])
    if @contact.update_attributes(contact_params)
      redirect_to contacts_path
    else
      render :new
    end
  end

  def contact_params
  	params.require(:contact).permit(:name,:email,:company,:conference,:tag_list,:user_id)
  end

end
