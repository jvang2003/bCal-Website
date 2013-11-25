class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      puts "success"
      flash[:success] = "You are now logged in"
      redirect_back_or calendars_path
    else
      puts "failure"
      puts @user.errors.full_messages
      render 'new'
    end
  end

  def index
    if params[:role]
      @users = User.where :role => params[:role]
    else
      @users = User.all
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    redirect_to users_path
  end

  private

    def user_params
      params[:user] # TODO: FIX BIG SECURITY HOLE
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
