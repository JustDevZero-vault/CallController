class Campaign
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :external_id, String
  property :file, String
  property :parsed, Boolean, :default => false
  property :active, Boolean, :default => false
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  belongs_to :user, :model => User
  #~ belongs_to :campaign_type, :model => CampaignType, :required => true
  belongs_to :campaign_type, :model => CampaignType  
  
  def initialize(external_id, campaign_type)
    begin
      self.external_id = external_id
      self.campaign_type = campaign_type
      if !self.save
        raise #couldn't save the object
      end
    rescue
      return false
    end
  end
  
  
  def blacklist(un)
    self.users << un
    self.save
  end
  
  def delist(un)
    member_rel = AgentBlacklistMember.get(un.id, self.id)
    if member_rel.nil?
      return false
    end
    member_rel.destroy
    self.reload
    user.reload
    return true
  end
  
  def process_import(un)
  
    include_fields = {}
    include_fields[:user] = un
    include_fields[:campaign] = self
    
    FSV.foreach(self.file,
                  :headers           => true,
                  :header_converters => :symbol,
                  :converters => :numeric
                  ) do |line|
                    line_hash = line.to_hash
                    hash_to_import = line_hash.merge(:include_fields)
                    OriginSales.create(hash_to_import.to_hash)
                  end
  end

end


class AgentBlacklistMember
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the RoleMember relation
   :default
  end

  belongs_to :user, :key => true
  belongs_to :campaign,  :key => true
end
