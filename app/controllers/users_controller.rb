class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You are now logged in"
      redirect_back_or root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params[:user] # TODO: FIX BIG SECURITY HOLE
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
