class UsersController < ApplicationController
  include UsersHelper
  skip_before_filter :require_login, :only => [:new,:create,:index]
  def self.can_view? user
    user && user.role >= 2
  end

  def self.can_crud? user
    user && user.role >= 2
  end

  before_filter :is_higher_admin?, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_back_or users_path
    else
      render :new
    end
  end

  def index
    if params[:role] and params[:role].length > 0
      @users = User.where :role => params[:role]
      @selected = params[:role]
    else
      @users = User.all
    end
  end

  def destroy
    @user ||= User.find params[:id]
    @user.destroy

    redirect_to users_path
  end

  def edit
    @user ||= User.find(params[:id])
  end

  def update
    @user ||= User.find(params[:id])

    @user.name = params["user"]["name"]
    @user.calnet_id = params["user"]["calnet_id"]
    @user.role = params["user"]["role"]
    if @user.save
      flash[:notice]="User has been successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  private

    def user_params
      params[:user] # TODO: FIX BIG SECURITY HOLE
    end

    def is_same_controller_and_action?(url1, url2)
      hash_url1 = Rails.application.routes.recognize_path(url1)
      hash_url2 = Rails.application.routes.recognize_path(url2)

      [:controller, :action].each do |key|
        return false if hash_url1[key] != hash_url2[key]
      end

      return true
    end
end
