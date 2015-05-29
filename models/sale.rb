class Sale
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
   :sale_db
  end
  
  property :id, Serial, :key => true
  property :name, String
  property :surname, String
  property :street, String
  property :postal_code, String
  property :email, String
  property :phone, String
  property :city, String
  property :province, String
  property :call_date, Integer, :default => DateTime.now
  property :call_back_date, Integer
  property :call_result, Integer, :default => 3
  property :created_by, Integer
  property :created_at, DateTime
  property :updated_by, Integer
  property :updated_at, DateTime
  belongs_to :call_result, :model => CallResult
  belongs_to :user, :model => User
  belongs_to :campaign, :model => Campaign
  belongs_to :product, :model => Product, :required => false
  belongs_to :origin, :model => OriginSales, :required => false
  
end
