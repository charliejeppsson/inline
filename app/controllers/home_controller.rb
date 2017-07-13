class HomeController < ApplicationController
  def index
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = policy_scope(Conversation).includes(:recipient, :messages)
                                 .find(session[:conversations])

  end
end
