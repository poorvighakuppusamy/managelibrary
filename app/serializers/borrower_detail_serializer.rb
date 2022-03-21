class BorrowerDetailSerializer < ActiveModel::Serializer
  attributes :id, :status, :borrowed_date, :return_date
  belongs_to :book
  belongs_to :user
end
