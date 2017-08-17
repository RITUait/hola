class ContactsController < ApplicationController
  def index
    @contacts = Contact.all.paginate(page: params[:page], per_page: 10)
  end

  def import
    Contact.import(params[:file])
    redirect_to contacts_path, notice: "contacts imported."
  end

end
