class ReminderDaysMailer < ApplicationMailer
  def reminder_days_email(user_id,book_id,borrower_id)
    @user = User.find_by(id: user_id)
    @book = Book.find_by(id: book_id)
    @borrower = BorrowerDetail.find_by(id:borrower_id)
    mail :to => @user.email, :from => "admin@abclibrary.com", :subject => "READING ROOM AT THE BRITISH MUSEUM - Reminder "
  end
end