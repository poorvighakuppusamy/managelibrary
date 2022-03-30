class UsersController < ApplicationController
	include Authenticator
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[sign_in sign_up refer_user]


	def sign_up
		user_parameter = user_params
		user_parameter["password"] = encrypt(user_parameter["password"])
		@userobj = User.new(user_parameter)
		@userobj.save
		UserMailer.user_confirmation(@userobj.id).deliver_later
		render json:@userobj
	end

	def refer_user
		user_parameter = params[:email]
		UserMailer.refer_app(params[:email]).deliver_later
		render json:{message: "User referred"}
	end

  def sign_in
		@user = User.find_by(email: params[:username])
		password = encrypt(params[:password])
		if @user && password == @user.password
			session[:user] = params[:username]
			render json: {
  				access_token: params[:username],
				  token_type: 'bearer'
      }
		else
			render status: 401, json: {error: 'invalid_grant'}
		end
	end

	def sign_out
		session[:user] = nil
  	render json: {message: "Successfully Logged Out"}
	end

	def show
		@user = User.find(params[:id])
		render json:@user
	end
	def index
		@user = User.all
		render json:@user
	end

	private
	def user_params
		# params.require(:data).require(:attributes).permit(:name, :email, :phone)
		params.permit(:name, :email, :password, :phone, :role_id)
	end
end
