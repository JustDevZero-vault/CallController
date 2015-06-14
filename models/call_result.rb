# -*- coding: utf-8 -*-
class CallResult
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end
  
  property :id, Serial, :key => true
  property :code, String
  property :description, String
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :user, :model => User
  has n, :sales
  
end
