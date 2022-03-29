class ReminderMailer < ApplicationMailer
	def reminder_email(user_id,book_id)
		@user = User.find_by(id: user_id)
		@book = Book.find_by(id: book_id)
		mail :to => @user.email, :from => "admin@abclibrary.com", :subject => "ABC Library - Reminder "
	end
end
