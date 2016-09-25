class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, Text, :required => true
  property :content, Text, :required => true
  property :public, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :user
end
