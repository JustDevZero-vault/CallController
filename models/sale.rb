class Sale
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end
  
  property :id, Serial, :key => true
  property :first_name, String
  property :last_name, String
  property :street, String
  property :postal_code, String
  property :email, String
  property :phone, String
  property :city, String
  property :call_date, DateTime
  property :call_back_date, DateTime
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :call_result, :model => CallResult
  belongs_to :user, :model => User
  belongs_to :campaign, :model => Campaign
  belongs_to :province, :model => Province
  belongs_to :product, :model => Product, :required => false
  belongs_to :origin, :model => OriginSale, :required => false
  belongs_to :call_result, :model => CallResult, :required => true
  
  
  #~ validates_with_method   :phone,
                          #~ :method => :is_valid_phone
  validates_format_of     :email,
                          :with => :email_address
  validates_format_of     :first_name,
                          :with => /^[\p{L} '&;]+$/i, :message => 'First Name with invalid characters'
  validates_format_of     :last_name,
                          :with => /^[\p{L} '&;]+$/i, :message => 'Last Name with invalid characters'
  validates_format_of     :city,
                          :with => /^[\p{L} '&;]+$/i, :message => 'City with invalid characters'
  validates_with_method   :province,
                          :method => :is_valid_province
                          
  def is_valid_phone
    result = OriginSale.is_valid_phone?(self.phone)
    if !result
      self.errors.add(:phone, "Phone is not valid")
    end
    return result
  end
  
  def self.is_valid_phone?(phone)
    result = /^((\+?34([ \t|\-])?)?[9|6|7]((\d{1}([ \t|\-])?[0-9]{3})|(\d{2}([ \t|\-])?[0-9]{2}))([ \t|\-])?[0-9]{2}([ \t|\-])?[0-9]{2})$/ === phone.to_s
    return result
  end
  
  def is_valid_province
    result = Province.first(self.province)
    if !result
      self.errors.add(:province, "Province is not valid")
    end
    return result
  end
  
end
