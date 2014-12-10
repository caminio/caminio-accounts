class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :firstname, :lastname, :role
  has_many :organizations, embed_in_root: true, embed: :ids
end
