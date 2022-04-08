class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  belongs_to :author
end
