class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def import
    Contact.import(params[:file])
    redirect_to contacts_path, notice: "contacts imported."
  end
  
end
