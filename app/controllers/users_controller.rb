class UsersController < ApplicationController
	include Authenticator
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[sign_in create refer_user]


	def create
		user_parameter = user_params
		user_parameter["password"] = encrypt(user_parameter["password"])
		user_parameter["role_id"] = 1
		@userobj = User.new(user_parameter)
		@userobj.save
		UserMailer.user_confirmation(@userobj.id).deliver_later
		render json:@userobj
	end


  def sign_in
		@user = User.find_by(email: params[:username])
		password = encrypt(params[:password])
		if @user && password == @user.password
			session[:user] = params[:username]
			render json: {
  				access_token: params[:username],
				  token_type: 'bearer',
				  role: @user.role.name
      }
		else
			render status: 401, json: {error: 'invalid_grant'}
		end
	end

	def sign_out
		session[:user] = nil
  	render json: {message: "Successfully Logged Out"}
	end

	def destroy
		@user = User.find(params[:id]).destroy;
		render json:@user
	end

	def show
		@user = User.find(params[:id])
		render json:@user
	end
	def index
		if params[:page]
			@user = User.page(params[:page])
		else
			@user = User.all
		end
		render json:@user
	end

	private
	def user_params
		params.require(:data).require(:attributes).permit(:name, :email, :phone, :password)
		# params.permit(:name, :email, :password, :phone)
	end
end
