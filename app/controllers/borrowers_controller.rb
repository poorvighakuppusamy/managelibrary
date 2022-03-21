class BorrowersController < ApplicationController
	skip_before_action :verify_authenticity_token 
	skip_before_action :authenticate_user, only: %i[show]
	def show
		@borrower_details = BorrowerDetail.all
		render json:@borrower_details
	end

	def create
		user_parameters = user_params
		user_parameters["borrowed_date"] = Date.today
		user_parameters["return_date"] = Date.today + 15.days
		@borrower_details = BorrowerDetail.create(user_parameters)
		BorrowerMailer.borrowed_details(@borrower_details.id).deliver_later
		render json:@borrower_details
	end

	def return_book
		@user = User.find_by(email: params[:email])
		user_id = @user.id
		@book = Book.find_by(title: params[:title])
		book_id = @book.id
		borrower = BorrowerDetail.find_by(user_id: user_id,book_id: book_id)
		borrwer.update(status: "Returned")
		render json:{message: "Book returned"}
	end

	private
	def user_params
		params.permit(:book_id, :user_id, :status)
	end
end
