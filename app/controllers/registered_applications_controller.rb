class RegisteredApplicationsController < ApplicationController
  def show
    @app = RegisteredApplication.find(params[:id])
    @user = User.find(current_user.id)
  end

  def index
    @apps = RegisteredApplication.where("user_id == ?", current_user.id)
    @user = User.find(current_user.id)
  end

  def new
    @app = RegisteredApplication.new
  end

  def create
    @app = RegisteredApplication.new(app_params)
    @app.user = current_user

    if @app.save
      flash[:notice] = "Registered new application."
      redirect_to @app
    else
      flash.now[:alert] = "There was an error registering teh app."
      render :new
    end
  end

  private

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end
end
