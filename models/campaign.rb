class Campaign
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
   :blacklist_agent_db
  end

  property :id, Serial, :key=> true
  property :external_id, String
  property :file, String
  property :parsed, Boolean
  property :active, Boolean
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  belongs_to :user, :model => User
  belongs_to :campaign_type, :model => CampaignType, :required => false
  
  
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

end


class AgentBlacklistMember
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the RoleMember relation
   :users_db
  end

  belongs_to :user, :key => true
  belongs_to :campaign,  :key => true
end
