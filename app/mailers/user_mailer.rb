class UserMailer < ApplicationMailer

	def user_confirmation(user_id)
		@user = User.find_by(id: user_id)
		mail :to => @user.email, :from => "admin@abclibrary.com", :subject => "ABC Library - User "+@user.name + " has been added as a member"
	end
end
