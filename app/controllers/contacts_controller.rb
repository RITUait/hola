class ContactsController < ApplicationController
  def index
    @contacts = Contact.all.paginate(page: params[:page], per_page: 10)
   
  end

  def import
    Contact.import(params[:file])
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
    @contact = Contact.new(contact_params)
    if @contact.save
        redirect_to contacts_path
    else
        render :new
    end
  end
  def edit
    @contact = Contact.find(params[:id])
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
  	params.require(:contact).permit(:name,:email,:company,:conference,:tag_list)
  end

end
