require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:user) { create(:user) }
  let(:app) { create(:registered_application, user: user) }
  let(:event) { create(:event, registered_application: app) }

  before do
    sign_in user
  end

  describe "GET show" do
    it "returns HTTP success" do
      get :show, {id: app.id, user_id: user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: app.id, user_id: user.id}
      expect(response).to render_template(:show)
    end

    it "assigns app to @app, event to @app.events, and user to @user" do
      get :show, {id: app.id, user_id: user.id}
      expect(assigns[:app]).to eq(app)
      expect(assigns[:user]).to eq(user)
      expect(assigns[:app].events).to eq([event])
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

  describe "GET new" do
    it "returns HTTP success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders #new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates @app" do
      get :new
      expect(assigns(:app)).to_not be_nil
    end
  end

  describe "POST create" do
    it "increases the number of registered_applications by one" do
      expect{
        post :create, registered_application: {name: Faker::StarWars.character, url: Faker::Internet.url}
      }.to change(RegisteredApplication, :count).by(1)
    end

    it "assigns new app to @app" do
      post :create, registered_application: {name: Faker::StarWars.character, url: Faker::Internet.url}
      expect(assigns(:app)).to eq(RegisteredApplication.last)
    end

    it "redirects to new app" do
      post :create, registered_application: {name: Faker::StarWars.character, url: Faker::Internet.url}
      expect(response).to redirect_to(registered_application_path(RegisteredApplication.last))
    end
  end

  describe "GET edit" do
    it "returns HTTP success" do
      get :edit, {id: app.id}
      expect(response).to have_http_status(:success)
    end

    it "renders #edit template" do
      get :edit, {id: app.id}
      expect(response).to render_template(:edit)
    end

    it "assigns app to @app" do
      get :edit, {id: app.id}
      expect(assigns(:app)).to eq(app)
    end
  end

  describe "PUT update" do
    it "updates app with expected attributes" do
      new_name = Faker::StarWars.character
      new_url = Faker::Internet.url

      put :update, id: app.id, registered_application: {name: new_name, url: new_url}
      updated_app = assigns(:app)

      expect(updated_app.id).to eq(app.id)
      expect(updated_app.name).to eq(new_name)
      expect(updated_app.url).to eq(new_url)
    end

    it "redirects to the updated app" do
      put :update, id: app.id, registered_application: {name: Faker::StarWars.character, url: Faker::Internet.url}
      expect(response).to redirect_to(registered_application_path)
    end
  end

  describe "DELETE destroy" do
    it "deletes an app" do
      delete :destroy, id: app.id
      expect(RegisteredApplication.where({id: app.id}).size).to eq(0)
    end

    it "redirects to app#index after deletion" do
      delete :destroy, id: app.id
      expect(response).to redirect_to(registered_applications_path)
    end
  end
end
