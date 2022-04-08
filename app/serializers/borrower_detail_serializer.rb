class BorrowerDetailSerializer < ActiveModel::Serializer
  attributes :id, :status, :borrowed_date, :return_date
  belongs_to :book
  belongs_to :user

  def return_date
    object.return_date&.to_time&.to_i * 1000
  end
  
  def borrowed_date
    object.return_date&.to_time&.to_i * 1000
  end

end
