class DashboardController < ApplicationController
  def index
    @contacts = Contact.all
    @c = []
  end

end
