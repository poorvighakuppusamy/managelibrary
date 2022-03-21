class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private
  def authenticate_user
    unless session[:user]
      render json: {error: "Authentication Failed"}
    end 
  end
end
