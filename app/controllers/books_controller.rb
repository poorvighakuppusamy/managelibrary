class BooksController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user, only: %i[show index show]

	def show
		@book = Book.find(params[:id])
		render json:@book
	end

	def index
		@book = Book.all
		render json:@book, include: [:author]
   end

	def create
		@book = Book.create(book_params)
		authorize @book
		render json: @book
	end

	private

	def book_params
		# params.permit(:title, :description, :author_id)
		params.require(:data).require(:attributes).permit(:title, :description, :author_id)
	end
end
