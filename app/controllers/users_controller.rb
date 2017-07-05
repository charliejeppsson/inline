class UsersController < ApplicationController
  def index
    if params.has_key?(:search_value) and params[:search_value] != ""
      @results = User.user_search(params[:search_value])
    else
      @users = User.all
    end
    # render line_path(@line)
  end

  def show
    @user = User.find(params[:id])
  end
end
