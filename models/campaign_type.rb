class CampaignType
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
   :sale_db
  end
  
  property :id, Serial, :key => true
  property :name, String
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  belongs_to :user, :model => User
  
end
