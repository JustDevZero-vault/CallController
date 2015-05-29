class CallResult
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
   :sale_db
  end
  
  property :id, Serial, :key => true
  property :code, String
  property :description, String
  property :created_by, Integer
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  belongs_to :user, :model => User
  
end
