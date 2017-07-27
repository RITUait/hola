class HomeController < ApplicationController
  def index
    @templates = Template.all
  end

  def send_email
  end
end
