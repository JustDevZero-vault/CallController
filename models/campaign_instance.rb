class CampaignInstance
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end
  
  property :id, Serial, key =>  true
   
  property :name, String
  property :state, String, :required => true, :default => "NEW"
  property :runtime, Integer, :default => 0
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  property :destroyed_at, Date
  
  after :create do
    Delayed::Job.enqueue(self)
  end
  
  def initialize(campaign, user, mode)
    @cpg = campaign
    @un = user
    @mde = mode
  end
  
  def perform
  
    self.update(:state => "CAMPAIGN_CONNECTING")
    cn = Campaign.first(:id => @campaign)
    if @mde == 'import'
      self.update(:state => "RUNNING")
      begin
        instance = cn.process_import(un)
        self.update(:state => "FINISHED")
      rescue Exception => e
        Notification.create(:type => :error, :sticky => false, :message => "Email error: "+e.message)
        return
      end
    end
  end

end
