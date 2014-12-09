class AccessTokenSerializer < ActiveModel::Serializer
  attributes :token, :expires_at
end
