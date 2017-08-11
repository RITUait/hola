require 'rails_helper'

RSpec.describe SignaturesController, type: :controller do
	describe "GET index" do
    it "responds successfully with  status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
	end
	describe "GET new" do
    it "assigns @signatures" do
      get :new
		expect(response).to render_template(:new)
    end
	end
	describe "POST create" do
    it "creates signatures with valid parameters" do
      post :create, params: { signature: { name:"abcd" , email:"abcd@gmail.com"} }
      expect(response).to redirect_to dashboard_index_path
    end

    it "does not create signatures with invalid parameters" do
      post :create, params: { signature: { name:"" , email:"abv"} }
      expect(response).to render_template(:new)
    end
	end
  describe "POST update" do
  let(:signature) {Signature.create(name: "abcd", email: "abcd@gmail.com")}

  it "updates an signature with valid params" do
   post :update, id: signature, signature: {name: "abcd", email: "abcd@gmail.com"}
    expect(response).to redirect_to signatures_path
  end
  it "updates an signature with invalid params" do
   post :update, id: signature, signature: {name: "", email: "abcgmail.com"}
    expect(response).to render_template(:new)
  end
end
end
