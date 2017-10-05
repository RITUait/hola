class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts.paginate(page: params[:page], per_page: 10)
  end

  def import
    @errors = Contact.import(params[:file], current_user.id)
    @contacts = current_user.contacts.paginate(page: params[:page], per_page: 10)
    if @errors.present?  
      flash.now[:alert] = "CSV contains some errors"
      render :index
    else
      redirect_to contacts_path, notice: "contacts imported."
    end
  end

  def export
    attributes = %w{Name Email Company Conference}
    if @errors
      @download = CSV.generate(headers: true) do |csv|
        csv << attributes
        @errors.each do |message|
          csv << message 
        end
      end
    end
    send_data @download,type: "text/csv",filename: "contacts.csv"
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = current_user.id 
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    @contacts = current_user.contacts
    tag = @contact.tag_list
    email = @contact.email
    contact = @contacts.where(email: email).first
    if contact
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
