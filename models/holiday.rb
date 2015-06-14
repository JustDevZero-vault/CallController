class Holiday
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end
  
  property :id, Serial, :key => true
  property :description, String, :length => 100, :required => true
  property :date, Date, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :province, :model => Province
  
end
