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
		@user = User.find_by(email: params[:email])
		password = encrypt(params[:password])
		if @user && password == @user.password
			session[:user] = params[:email]
			render json: @user
			# respond_to do |format|
		 #    format.json { render json: @user }
		 #    format.html { redirect_to "http://localhost:4200/home" }
		 #  end
		else
			render json: {error: "Authentication Failed"}
		end
	end

	def sign_out
		session[:user] = nil
  	render json: {message: "Successfully Logged Out"}
	end

	def show
		authorize current_user
		@user = User.find(params[:id])
		render json:@user
	end
	def index
		authorize current_user
		@user = User.all
		render json:@user
	end

	private
	def user_params
		# params.require(:data).require(:attributes).permit(:name, :email, :phone)
		params.permit(:name, :email, :password, :phone, :role_id)
	end
end
