class ReferUsersController < ApplicationController
  include Authenticator
  skip_before_action :verify_authenticity_token

  def create
    user_parameter = user_params
    @userobj = ReferUser.new(user_parameter)
    @userobj.save
    UserMailer.refer_app(user_parameter["email"]).deliver_later
    render json: @userobj
  end

  private
  def user_params
    params.require(:data).require(:attributes).permit(:email)
  end
end