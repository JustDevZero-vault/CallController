class Campaign
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :external_id, String
  property :file_name, String
  property :parsed, Integer, :default => 0, :max => 4
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
    write_mode = "wt"
    write_headers = true
    failed_imports = self.file_name.gsub(Regexp.new(/.csv$/), '.failed.csv')
    file_errors = self.file_name.gsub(Regexp.new(/.csv$/), '.errors.csv')
    File.delete(file_errors) if File.exist?(file_errors)
    File.delete(failed_imports) if File.exist?(failed_imports)
    self.update(:parsed => 2)
    CSV.foreach(self.file_name,
                :headers           => true,
                :header_converters => :symbol,
                :converters => :numeric
                ) do |line|
      error_string = ""
      line_hash = line.to_hash
      column_header = line.headers
      line_partial = line_hash.merge(include_fields)
      origin = OriginSales.first(line_partial.to_hash)
      include_fields[:user] = un
      hash_to_import = line_partial.merge(include_fields)
      if origin.nil?
        origin_sale = OriginSales.new(hash_to_import.to_hash)
        
        error_string += "Phone is not valid on line #{counter.to_s}" if !OriginSales.is_valid_phone?(line[:phone])
        error_string += "\nName is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:name])
        error_string += "\nSurname is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:surname])
        error_string += "\nCity is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:city])
        error_string += "\nProvince is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:province])
        #~ File.open(failed_imports,'at') {|file| file.puts "Province is not valid on line #{counter.to_s}"} if !(line.province=/^[\p{L} ']+$/i)
        
        if error_string.length > 0
        self.update(:parsed => 3)
          if counter > 1
            write_mode = "a"
            column_header = nil
            write_headers = false
          end
          CSV.open(failed_imports, write_mode, :write_headers=> write_headers, :headers => column_header) do |csv|
            csv << line
          end
          File.open(file_errors,'at') {|file| file.puts error_string}
        else
          begin
            origin_sale.save
          rescue StandardError => e
            error_string += "\nGot an error trying to import origin sales: #{e.to_s} on line #{counter.to_s}".gsub('OriginSales: ','') if !(line.province=/^[\p{L} ']+$/i)
          end
        end
        #~ if !error_string.empty?
      end
      counter += 1
    end
    if File.zero?(file_errors)
      self.update(:parsed => 1)
    else
      self.update(:parsed => 4)
      noti =  Notification.create(:type => :error, :sticky => false, :message => "Error importing origin sales for campaign #{self.external_id}") if File.zero?(file_errors)
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
