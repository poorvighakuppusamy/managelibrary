class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[show]
	def create
		user_parameter = user_params
		@user = User.create(user_parameter)
		UserMailer.user_confirmation(@user.id).deliver_later
		render json:@user
	end

	def show
		@user = User.all
		render json:@user
	end

	def show_user
		@user = User.find_by(id: params[:id])
		render json:@user
	end

	private
	def user_params
		params.permit(:name, :email, :phone)
	end
end
