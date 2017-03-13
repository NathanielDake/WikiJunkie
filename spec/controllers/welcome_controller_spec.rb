require 'rails_helper'

#Descrbie the subject of the spec, in this case `WelcomeController`
RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do

      #use `get` to call the `index` method of WelcomeController
      get :index

      #expect the controllers response to have a successful http status (200)
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index

      #expect the controllers response to render the `index` template
      expect(response).to render_template("index")
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end

    it "renders the about template" do
      get :about

      #expect the controllers response to render the `about` template
      expect(response).to render_template("about")
    end
  end

end
