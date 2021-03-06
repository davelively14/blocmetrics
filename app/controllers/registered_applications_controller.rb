class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @app = RegisteredApplication.find(params[:id])
    @user = User.find(current_user.id)
    @events = @app.events.group_by(&:name)
  end

  def index
    @apps = RegisteredApplication.where("user_id = ?", current_user.id)
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
      flash.now[:alert] = "There was an error registering the app."
      render :new
    end
  end

  def edit
    @app = RegisteredApplication.find(params[:id])
  end

  def update
    @app = RegisteredApplication.find(params[:id])
    @app.assign_attributes(app_params)

    if @app.save
      flash[:notice] = "#{@app.name} was updated successfully."
      redirect_to registered_application_path(@app)
    else
      flash.now[:alert] = "There was an error updating the app."
      render :edit
    end
  end

  def destroy
    @app = RegisteredApplication.find(params[:id])

    if @app.destroy
      flash[:notice] = "#{@app.name} was unregistered successfully."
      redirect_to registered_applications_path
    else
      flash.now[:notice] = "There was an error unregistering the app."
      render :index
    end
  end

  private

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end
end
