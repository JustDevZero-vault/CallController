class CampaignType
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end
  
  property :id, Serial, :key => true
  property :name, String
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  has n, :campaigns
  
=begin
  def initialize(name)
    begin
      self.name = name
      if !self.save
        raise #couldn't save the object
      end
    rescue
      return false
    end
  end
=end
end
