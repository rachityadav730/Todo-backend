class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :admin, :merchant_id
end
