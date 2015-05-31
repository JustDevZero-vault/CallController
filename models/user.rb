class User
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :username, String
  property :first_name, String
  property :last_name, String
  property :email, String
  property :password, BCryptHash
  property :receive_notifications, Boolean, :default => false 
  property :token, String
  property :active, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :role_members
  has n, :roles, :through => :role_members
  has n, :agent_blacklist_members
  has n, :campaigns, :through => :agent_blacklist_members

  def initialize(username, email, password)
    begin
      self.username = username
      self.email = email
      enc_pw = BCrypt::Password.create(password)
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
    is_admin = self.roles.count(:capabilities => 'admin')
    if is_admin == 0
      return false
    else
      return true
    end
  end

  def is_agent?
    is_agent = self.roles.count(:capabilities => 'agent')
    if is_agent == 0
      return false
    else
      return true
    end
  end

  def is_supervisor?
    is_supervisor = self.roles.count(:capabilities => 'supervisor')
    if is_supervisor == 0
      return false
    else
      return true
    end
  end

  def is_coacher?
    is_coacher = self.roles.count(:capabilities => 'coacher')
    if is_coacher == 0
      return false
    else
      return true
    end
  end

  def is_manager?
    is_manager = self.roles.count(:capabilities => 'manager')
    if is_manager == 0
      return false
    else
      return true
    end
  end

end
