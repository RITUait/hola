class DashboardController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate_user!
  def index
    @contact = Contact.new
    @signature = Signature.new
    #@contacts = Contact.all
    @user = current_user.id
    @contacts = current_user.contacts
    @signatures = current_user.signatures
    @c = []
    @contacts.tag_counts.each do |t|
      contacts = current_user.contacts.tagged_with(t.name)
      @c << {"tag" => t.name, "notsent" => contacts.where(status: false).count, "sent" => contacts.where(status: true).count, "total" => contacts.count }
    end
    @page = @c.paginate(page: params[:page], per_page: 10)
    if (@contacts.empty?) && (@signatures.empty?)
      redirect_to home_index_path
    end
  end

end
