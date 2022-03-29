class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: {error: 'User not authorized'}
  end


  def authenticate_user
    unless session[:user]
      # respond_to do |format|
      #   format.html { redirect_to "/users/sign_in" }
      #   format.json { render json: {error: "Authentication Failed"} }
      # end
      render json: {error: "Authentication Failed"}
    end 
  end

  def current_user
    @current_user ||= User.find_by_email(session[:user])
  end
end
