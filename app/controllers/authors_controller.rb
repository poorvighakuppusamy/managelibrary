class AuthorsController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[show]
	def create
		user_parameters = user_params
		@author=Author.create(user_parameters)
		render json:@author
	end

	def show
		@author = Author.all
		render json:@author
	end

	def show_author
		@author = Author.find_by(id: params[:id])
		render json:@author
	end
	
	private
	def user_params
		params.permit(:name, :Description)
	end
end
