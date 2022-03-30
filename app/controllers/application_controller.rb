class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    # render json: {error: 'User not authorized'}
    render status: 401, json: {error: 'User not authorized'}
  end


  def authenticate_user
    # unless session[:user]
    if request.headers['Authenticate'].blank? || current_user.nil?
      render json: {error: "Authentication Failed"}
    end 
  end

  def current_user
    # @current_user ||= User.find_by_email(session[:user])
    @current_user ||= User.find_by_email(request.headers['Authenticate'])
  end
end
