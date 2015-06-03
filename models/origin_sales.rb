class OriginSales
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end
  
  property :id, Serial, :key => true
  property :name, String
  property :surname, String
  property :street, String
  property :postal_code, String
  property :email, String, :messages => {:format => "Does not lot look like an email address to me ...", :presence  => "We need your email address."}
  property :phone, String
  property :city, String
  property :province, String
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :user, :model => User
  belongs_to :campaign, :model => Campaign
  
  
  #~ validates_with_method :phone,
                        #~ :method => :is_valid_phone,
                        #~ :message => { :presence => "We need a phone", :format => "Does not look like a spanish phone"}
                        
  validates_with_method   :phone,
                        :method => :is_valid_phone
  validates_format_of   :email,
                        :with => :email_address



  def is_valid_phone
    result = /^((\+?34([ \t|\-])?)?[9|6|7]((\d{1}([ \t|\-])?[0-9]{3})|(\d{2}([ \t|\-])?[0-9]{2}))([ \t|\-])?[0-9]{2}([ \t|\-])?[0-9]{2})$/ === self.phone
    if !result
      elf.errors.add(:phone, "Phone is not valid")
    end
    return result
  end
  
  
end

