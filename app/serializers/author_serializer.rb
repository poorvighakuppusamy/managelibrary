class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :Description
  has_many :books
end
