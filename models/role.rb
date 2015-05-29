class Role
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
   :users_db
  end

  property :id, Serial, :key => true
  property :name, String
  property :capabilities, String, :default => 'agent'
  property :created_by, Integer
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  has n, :role_members
  has n, :users, :through => :role_members

  def add_member(user)
    self.users << user
    self.save
  end

  def del_member(user)
    member_rel = RoleMember.get(user.username, self.name)
    if member_rel.nil?
      return false
    end
    member_rel.destroy
    self.reload
    user.reload
    return true
  end

end

class RoleMember
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the RoleMember relation
   :users_db
  end

  belongs_to :user,  :key => true
  belongs_to :role, :key => true
end
