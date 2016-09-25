class User
  include DataMapper::Resource

  property :id       , Serial
  property :uid      , Integer
  property :provider , String
  property :name     , String

  has n, :posts
end
