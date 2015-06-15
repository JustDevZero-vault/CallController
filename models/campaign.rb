# -*- coding: utf-8 -*-
class Campaign
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :external_id, String
  property :file_name, String, :length => 255
  property :parsed, String, :default => 'unparsed'
  property :processed, String, :default => 'unprocessed'
  property :active, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :campaign_type, :model => CampaignType
  belongs_to :call_queue, :model => CallQueue
  
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
    error_counter = 0
    write_mode = "wt"
    write_headers = true
    failed_imports = self.file_name.gsub(Regexp.new(/.csv$/), '.failed.csv')
    file_errors = self.file_name.gsub(Regexp.new(/.csv$/), '.errors.csv')
    File.delete(file_errors) if File.exist?(file_errors)
    File.delete(failed_imports) if File.exist?(failed_imports)
    self.update(:parsed => 'parsing')
    ht = HTMLEntities.new
    
    file_to_parse = self.file_name
    file_fixed = file_to_parse.gsub(Regexp.new('.csv$'), '.fixed.csv')
    if File.exist?(file_fixed)
      file_to_parse = file_fixed
    else
      file_to_parse = self.file_name
    end
    CSV.foreach(file_to_parse,
                :headers           => true,
                :header_converters => :symbol,
                # :converters => :numeric
                ) do |line|
      error_string = ""
      line_hash = line.to_hash
      column_header = line.headers
      line_partial = line_hash.merge(include_fields)
      new_hash = {}
      new_hash = new_hash.merge(include_fields)
      new_hash[:edad] = line_partial[:Edad]
      new_hash[:external_id] = line_partial[:ID_user]
      new_hash[:first_name] = line_partial[:Nombre]
      new_hash[:last_name] = line_partial[:Apellidos]
      
      cp = line_partial[:cp].to_s.rjust(5, '0')
      new_hash[:postal_code] = new_hash[:cp].to_s.rjust(5, '0')
      firstcp = cp[0..1]
       notification = Notification.create(:type => :error, :sticky => false, :message => firstcp)
      province = Province.first(:postal_code => firstcp)
      new_hash[:province] = province.name
      new_hash[:postal_code] = cp
      new_hash[:phone] = line_partial[:TELEFONO1_]
      
          
      origin = OriginSale.first(new_hash.to_hash)
      include_fields[:user] = un
      hash_to_import = line_partial.merge(include_fields)
      if origin.nil?
        error_string += "Phone is not valid on line #{counter.to_s} - #{line[:TELEFONO1_]}" if !OriginSale.is_valid_phone?(line[:telefono1_])
        error_string += "\nFirst Name is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:nombre])
        error_string += "\nLast Name is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:apellidos])
        # error_string += "\nCity is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:city])
        # error_string += "\nProvince is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:province])
        error_string += "\nID_user is not valid on line #{counter.to_s}" if !(/^[\p{N}]+$/i === line[:id_user])
        error_string += "\nCP is not valid on line #{counter.to_s}" if !(/^[\p{N}]+$/i === line[:cp])
        error_string += "\nEdad is not valid on line #{counter.to_s}" if !(/^[\p{N}]+$/i === line[:edad])
        #~ File.open(failed_imports,'at') {|file| file.puts "Province is not valid on line #{counter.to_s}"} if !(line.province=/^[\p{L} ']+$/i)
        
        if error_string.length > 0
        error_counter += 1
        self.update(:parsed => 'parsing_with_errors')
          if error_counter > 1
            write_mode = "at"
            column_header = nil
            write_headers = false
          end
          CSV.open(failed_imports, write_mode, :write_headers=> write_headers, :headers => column_header) do |csv|
            csv << line
          end
          File.open(file_errors,'at') {|file| file.puts error_string}
        else
          # new_hash = {}
          # new_hash[:city] = ht.encode(hash_to_import[:city], :named)
          new_hash[:city] = " "
          # hash_to_import[:province] = ht.encode(hash_to_import[:province], :named)
          new_hash[:edad] = ht.encode(hash_to_import[:edad], :named)
          new_hash[:first_name] = ht.encode(hash_to_import[:nombre], :named)
          new_hash[:last_name] = ht.encode(hash_to_import[:apellidos], :named)
          # new_hash[:street] = ht.encode(hash_to_import[:street], :named)
          new_hash[:street] = " "
          # new_hash[:email] = ht.encode(hash_to_import[:email], :named)
          new_hash[:email] = " "
          origin_sale = OriginSale.new(new_hash.to_hash)
          begin
            origin_sale.save
          rescue StandardError => e
            error_string += "\nGot an error trying to import origin sales: #{e.to_s} on line #{counter.to_s}".gsub('OriginSale: ','')
          end
        end
      end
      counter += 1
    end
    if File.zero?(file_errors) || !File.exist?(file_errors)
      self.update(:parsed => 'parsed')
    else
      self.update(:parsed => 'parsed_with_errors')
      noti =  Notification.create(:type => :error, :sticky => false, :message => "Error importing origin sales for campaign #{self.external_id}")
    end
  end
  
  def migrate_to_sales
    self.update(:processed => 'processing')
    error_counter = 0
    default_call = CallResult.first(:code => 'Undefined')
    default_user = User.first(:username => 'queue')
    
    original_sales_to_migrate = OriginSale.all(:campaign => self)
    sales_to_migrate = original_sales_to_migrate
    need_review = OriginSale.all(:review => true, :campaign => self)
    sales_to_migrate = need_review if need_review.count > 0
    
       
    sales_to_migrate.each do |origin|
      error_string = ""
      if !origin.nil? && !default_call.nil?
        province = Province.first(:name => origin.province)
        error_string += "\nProvince is not valid for sale #{origin.id.to_s} fix it." if province.nil?
        if !error_string.empty? || error_string.length > 0
          error_counter += 1
          self.update(:processed => 'processing_with_errors')
          origin.update(:review => true)
        else
          begin
            sale = Sale.first_or_create(
            :first_name => origin.first_name,
            :last_name => origin.last_name,
            :street => origin.street,
            :edad => origin.edad,
            :postal_code => origin.postal_code,
            :email => origin.email,
            :phone => origin.phone,
            :city => origin.city,
            :province => province,
            :call_result => default_call,
            :campaign => self,
            :user => default_user,
            :origin => origin
            )
          rescue StandardError => e
            error_string += "\nGot an error trying to migrate sales: #{e.to_s} on origin sale #{origin.id.to_s}".gsub('Sale: ','')
          end
          origin.update(:review => false) if !sale.nil?
        end
      end
    end
    need_review = OriginSale.all(:review => true, :campaign => self)
    if need_review.count.to_i == 0
      sales = Sale.all(:campaign => self)
      if sales.count.to_i == original_sales_to_migrate.count.to_i
        self.update(:processed => 'processed')
      elsif sales.count == 0
        self.update(:processed => 'unprocessed')
      else
        self.update(:processed => 'processed_with_errors')
      end
    else
      self.update(:processed => 'processed_with_errors')
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
