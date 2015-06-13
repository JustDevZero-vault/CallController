class CallQueue
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :name, String
  property :created_by, Integer
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  has n, :queue_members
  has n, :users, :through => :queue_members
  

  def add_member(un)
    self.users << un
    self.save
  end

  def del_member(un)
    member_rel = QueueMember.get(un.id, self.id)
    if member_rel.nil?
      return false
    end
    member_rel.destroy
    self.reload
    un.reload
    return true
  end

end

class QueueMember
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the RoleMember relation
   :default
  end

  belongs_to :user,  :key => true
  belongs_to :call_queue, :key => true
end
