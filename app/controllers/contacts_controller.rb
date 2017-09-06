class ContactsController < ApplicationController
  def index
    p @contacts = current_user.contacts.paginate(page: params[:page], per_page: 10)
   
  end

  def import
    Contact.import(params[:file], current_user.id)
    redirect_to contacts_path, notice: "contacts imported."
  end
  def export
  	@data = Contact.order(:created_at)
  	respond_to do |format|
   	 format.html { redirect_to root_url }
     format.csv { send_data @data.to_csv }
  	end
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = current_user.id
    @contacts = current_user.signatures    
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contacts.empty?
      if @contact.save
        redirect_to root_path
      else
        render :new
        p @contact.errors
      end
    else
      if @contact.save
        redirect_to contacts_path
      else
        render :new
        p @contact.errors
      end
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
