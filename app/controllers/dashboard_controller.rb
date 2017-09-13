class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
  	@contact = Contact.new
	  @signature = Signature.new
    #@contacts = Contact.all
    @user = current_user.id
    p @contacts = current_user.contacts
    @signatures = current_user.signatures
    @c = []
    if (@contacts.empty?) && (@signatures.empty?)
      redirect_to home_index_path
    end
  end

end
