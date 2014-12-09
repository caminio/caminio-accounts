class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :firstname, :lastname, :role
end
