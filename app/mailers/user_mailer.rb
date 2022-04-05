class UserMailer < ApplicationMailer

	def user_confirmation(user_id)
		@user = User.find_by(id: user_id)
		mail :to => @user.email, :from => "admin@abclibrary.com", :subject => "READING ROOM AT THE BRITISH MUSEUM - User "+@user.name + " has been added as a member"
	end

	def refer_app(email)
		mail :to => email, :from => "admin@abclibrary.com", :subject => "You have been referred to use Library"
	end
end
