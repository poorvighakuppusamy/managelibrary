class AuthorsController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[show index create]
	def create
		user_parameters = user_params
		@author=Author.new(user_parameters)
		authorize @author
		@author.save
		render json:@author
	end

	def show
		@author = Author.find(params[:id])
		render json:@author
	end

	def index
		@author = Author.includes(:books).page(params[:page])
		# @author = Author.includes(:books).all
		render json:@author
    end

  def update
		@author = Author.find(params[:id])
		authorize @author
		user_parameters = user_params
		@author.update(user_parameters)
		render json:@author
	end
	
	private
	def user_params
		params.require(:data).require(:attributes).permit(:name, :description)
		# params.permit(:name, :description)
	end
end
