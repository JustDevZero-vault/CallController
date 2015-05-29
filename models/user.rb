class User
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the User objects
   :users_db
  end

  property :id, Serial, :key => true
  property :username, String
  property :email, String
  property :password, BCryptHash
  property :receive_notifications, Boolean, :default => false 
  property :token, String
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :team_members
  has n, :teams, :through => :team_members
  has n, :agent_blacklist_members
  has n, :campaigns, :through => :agent_blacklist_members

  def initialize(username, email, password)
    begin
      self.username = username
      self.email = email
      enc_pw = SCrypt::Password.create(password)
      self.password = enc_pw
      if !self.save
        raise #couldn't save the object
      end
    rescue
      return false
    end
  end

  def self.auth(username, password)
    un = username.to_s.downcase
    u = first(:conditions => ['lower(email) = ? OR lower(username) = ?', un, un])
    if u && u.password == password
      return u
    else
      return false
    end
  end

  def is_admin?
    is_admin = self.teams.count(:capabilities => 'admin')
    if is_admin == 0
      return false
    else
      return true
    end
  end

  def is_agent?
    is_agent = self.teams.count(:capabilities => 'agent')
    if is_agent == 0
      return false
    else
      return true
    end
  end

  def is_supervisor?
    is_supervisor = self.teams.count(:capabilities => 'supervisor')
    if is_supervisor == 0
      return false
    else
      return true
    end
  end

  def is_coacher?
    is_coacher = self.teams.count(:capabilities => 'coacher')
    if is_coacher == 0
      return false
    else
      return true
    end
  end

  def is_manager?
    is_manager = self.teams.count(:capabilities => 'manager')
    if is_manager == 0
      return false
    else
      return true
    end
  end

end
