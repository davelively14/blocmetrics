class RegisteredApplicationsController < ApplicationController
  def show
    @app = RegisteredApplication.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def index
    @apps = RegisteredApplication.where("user_id == ?", params[:user_id])
  end
end
