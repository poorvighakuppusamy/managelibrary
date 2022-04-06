class BorrowerDetailsController < ApplicationController
	skip_before_action :verify_authenticity_token 
	skip_before_action :authenticate_user, only: %i[create update]
	def index
		@borrower_details = BorrowerDetail.includes(:user,:book).page(params[:page])
		render json:@borrower_details
	end

	def show
		@borrower = BorrowerDetail.find(params[:id])
		render json:@borrower
	end

	def create
		user_parameters = user_params
		user_parameters["borrowed_date"] = Date.today
		user_parameters["return_date"] = Date.today + 15.days
		@borrower_details = BorrowerDetail.create(user_parameters)
		BorrowerMailer.borrowed_details(@borrower_details.id).deliver_later
		render json:@borrower_details
	end

	def update
		@borrower = BorrowerDetail.find(params[:id])
		authorize @borrower
		user_parameters = user_params
		@borrower.update(user_parameters)
		render json:@borrower
	end

	private
	def user_params
		params.require(:data).require(:attributes).permit(:book_id, :user_id, :status)
		# params.permit(:book_id, :user_id, :status)
	end
end
