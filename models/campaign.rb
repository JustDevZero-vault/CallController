class Campaign
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :external_id, String
  property :file_name, String
  property :parsed, Integer, :default => 0, :max => 1
  property :active, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :campaign_type, :model => CampaignType
  
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
  
  def process_import(un)
  
    include_fields = {}
    include_fields[:campaign] = self
    
    counter = 1
    file_errors = self.file_name.gsub(Regexp.new(/.csv$/), '.errors.csv')
    File.delete(file_errors) if File.exist?(file_errors)
    CSV.foreach(self.file_name,
                :headers           => true,
                :header_converters => :symbol,
                :converters => :numeric
                ) do |line|
      line_hash = line.to_hash
      line_partial = line_hash.merge(include_fields)
      origin = OriginSales.first(line_partial.to_hash)
      include_fields[:user] = un
      hash_to_import = line_partial.merge(include_fields)
      if origin.nil?
        origin_sale = OriginSales.new(hash_to_import.to_hash)
        begin
          origin_sale.save
          #~ Origin sale is saved
          #~ origin_sale.errors.each do |e|
        rescue DataMapper::SaveFailureError => e
          #~ error_message = e.message << "on line " << counter.to_s
          noti =  Notification.create(:type => :error, :sticky => false, :message => "Error importing origin sales: #{e.to_s} on line #{counter.to_s}".gsub('OriginSales: ','') )
          column_header = line.headers
          CSV.open(file_errors, "wt", :write_headers=> true, :headers => column_header) do |csv|
            column_header = nil
            csv << line
          end
        rescue StandardError => e
          noti =  Notification.create(:type => :error, :sticky => false, :message => "Got an error trying to import origin sales: #{e.to_s} on line #{counter.to_s}".gsub('OriginSales: ','') )
        end
      end
      counter += 1
    end
  end
  
    def file_imported?
      result_value = false
      if !self.file_name.nil?
          result_value = File.exist?(self.file_name)
      end
      return result_value
    end

end


class AgentBlacklistMember
  include DataMapper::Resource

  def self.default_repository_name #here we use the users_db for the RoleMember relation
   :default
  end

  belongs_to :user, :key => true
  belongs_to :campaign,  :key => true
end
