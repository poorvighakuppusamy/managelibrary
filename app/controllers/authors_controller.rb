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

	def destroy
		@author = Author.find(params[:id]).destroy;
		render json:@author
	end

	def index
		if params[:page]
			@author = Author.includes(:books).page(params[:page])
		else
			@author = Author.includes(:books).all
		end
		render json:@author, meta: {total_records: @author.total_count, current_page: @author.current_page, total_pages: @author.total_pages}
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
