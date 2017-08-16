require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe "GET index" do
    it "gets Contacts with tags" do
      get :index
      expect(response).to be_success
    end
	end

	describe "Contacts #import" do
    it "Imports contacts" do
      allow(Contact).to receive(:import).with("name.csv")
      post :import, params: { file: "name.csv" }
      expect(response).to redirect_to contacts_path
    end
	end
end
