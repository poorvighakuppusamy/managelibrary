class BooksController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[show] 
	def show
		@book = Book.all
		render json:@book
	end

	def show_book
		@author = Book.find_by(id: params[:id])
		render json:@book
	end

	def create
		user_parameters = user_params
		@book = Book.create(user_parameters)
		render json:@book
	end

	private
	def user_params
		params.permit(:title, :description, :author_id)
	end
end
