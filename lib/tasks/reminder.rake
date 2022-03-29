desc 'Reminder email to return the book'
  task reminder_email: :environment do
    @borrower = BorrowerDetail.where(return_date: Date.today+1.day)
    @borrower.each do |borrower|
      ReminderMailer.reminder_email(borrower.user_id, borrower.book_id).deliver_later
    end
  end

desc 'Reminder email to denote the number of days'
  task reminder_days_email: :environment do
    @borrower = BorrowerDetail.where(borrowed_date: Date.today-5.days)
    @borrower.each do |borrower|
      ReminderDaysMailer.reminder_days_email(borrower.user_id, borrower.book_id, borrower.id).deliver_later
    end
  end