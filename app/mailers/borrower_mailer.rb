class BorrowerMailer < ApplicationMailer
	def borrowed_details(borrower_id)
		@borrower = BorrowerDetail.find_by(id: borrower_id)
		mail :to => @borrower.user.email, :from => "admin@abclibrary.com", :subject => "ABC Library - User "+@borrower.user.name + " has borrowed a book "+@borrower.book.title
	end
end
