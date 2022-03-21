class AdminsController < ApplicationController
	include Authenticator
    skip_before_action :authenticate_user, only: %i[sign_in create]
    skip_before_action :verify_authenticity_token
	def create
		user_parameter = user_params
		user_parameter["password"] = encrypt(user_parameter["password"])
		@admin = Admin.create(user_parameter)
		render json:@admin
	end

	def sign_in
		@admin = Admin.find_by(email: params[:email])
		password = encrypt(params[:password])
		if password == @admin.password
			session[:user] = params[:email]
			render json: @admin
		else
			render json: {error: "Authentication Failed"}
		end
	end

	def sign_out
		session[:user] = nil
		render json: {message: "You are successfully Logged out"}
	end

	private
	def user_params
		params.permit(:name, :password, :email, :phone)
	end
end
