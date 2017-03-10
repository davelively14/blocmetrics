require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:user) { create(:user) }
  let(:app) { create(:registered_application, user: user) }

  describe "GET show" do
    it "returns HTTP success" do
      get :show, {id: app.id, user_id: user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: app.id, user_id: user.id}
      expect(response).to render_template(:show)
    end

    it "assigns app to @app and user to @user" do
      get :show, {id: app.id, user_id: user.id}
      expect(assigns[:app]).to eq(app)
      expect(assigns[:user]).to eq(user)
    end
  end

  describe "GET index" do
    it "returns HTTP success" do
      get :index, {user_id: user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #index view" do
      get :index, {user_id: user.id}
      expect(response).to render_template(:index)
    end

    it "assigns app to @apps" do
      get :index, {user_id: user.id}
      expect(assigns[:apps]).to eq([app])
    end
  end
end
