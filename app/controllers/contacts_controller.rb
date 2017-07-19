class ContactsController < ApplicationController
  def index
    if params[:tag]
      @contacts = Contact.tagged_with(params[:tag])
    else
      @contacts = Contact.all
    end
  end


  def import
    Contact.import(params[:file])
    redirect_to contacts_path, notice: "contacts imported."
  end
end
