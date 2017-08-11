require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
	describe "GET index" do
      it "renders the index template" do
      	@contacts = Contact.all
      	@c = []
      get :index
      expect(response).to render_template("index")
    end
  end
end
