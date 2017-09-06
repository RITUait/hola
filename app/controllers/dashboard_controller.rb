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
  end

end
