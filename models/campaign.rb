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
    codifications = ['UTF-8', 'IBM424_rtl']
    
    file_to_parse = self.file_name
    file_fixed = file_to_parse.gsub(Regexp.new('.csv$'), '.fixed.csv')
    if File.exist?(file_fixed)
      file_to_parse = file_fixed
    else
      file_to_parse = self.file_name
    end
    file_content = File.read(file_to_parse)
    detector = CharlockHolmes::EncodingDetector.new
    file_detection = detector.detect(file_content)
    converter = CharlockHolmes::Converter
    if file_detection[:encoding] == 'windows-1252'
      exec "iconv -f windows-1252 " + file_to_parse + " -t UTF-8 -o " + file_to_parse
    end
    CSV.foreach(file_to_parse,
                :headers           => true,
                :header_converters => :symbol,
                :encoding => file_detection[:encoding],
                # :converters => :numeric,
                ) do |line|
      error_string = ""
      line_hash = line.to_hash
      column_header = line.headers
      line_partial = line_hash.merge(include_fields)
      new_hash = {}
      #content = File.read('test2.txt')
      #detection = CharlockHolmes::EncodingDetector.detect(content)
      #utf8_encoded_content = CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
      # hash_to_import[:edad] = line_partial[:edad]
      # hash_to_import[:external_id] = line_partial[:id_user]
      # hash_to_import[:first_name] = line_partial[:nombre]
      # hash_to_import[:last_name] = line_partial[:apellidos]      hash_to_import[:edad] = line_partial[:edad]
      detection_external_id = detector.detect(line[:id_user])
      detection_first_name = detector.detect(line[:nombre])
      detection_last_name = detector.detect(line[:apellidos])
      detection_edad = detector.detect(line[:edad])
      detection_phone = detector.detect(line[:telefono1_])
      detection_postal_code = detector.detect(line[:cp])
      
      # STDERR.puts detection_last_name[:encoding] + "                  " + detection_phone[:confidence].to_s
      # ENCODING IS A MADNESS, CONFIDENCE 100 IS NOT NEITHER ENOUGH
      ncp = line[:cp]
      # if !codifications.include? detection_postal_code[:encoding]
        # if detection_postal_code[:confidence] > 60
          # ncp = converter.convert line[:id_user], detection_postal_code[:encoding], 'UTF-8'
        # end
      # end
      # if detection_postal_code[:encoding] != 'UTF-8'
        # ncp = line[:id_user].decode(detection_postal_code[:encoding])
      # end
      
      cp = ncp.to_s.rjust(5, '0')
      new_hash[:postal_code] = cp.to_s.rjust(5, '0')
      firstcp = new_hash[:postal_code][0..1]
      province = Province.first(:postal_code.like => firstcp + '%')
      

      # new_hash[:province] = province.name
      # new_hash[:postal_code] = cp
      # new_hash[:phone] = line_partial[:telefono1_]
      # new_hash[:city] = " "
      # new_hash[:external_id] = ht.encode(hash_to_import[:external_id], :named)
      # new_hash[:edad] = ht.encode(hash_to_import[:edad], :named)
      # new_hash[:first_name] = ht.encode(hash_to_import[:first_name], :named)
      # new_hash[:last_name] = ht.encode(hash_to_import[:last_name], :named)
      # new_hash[:street] = " "
      # new_hash[:email] = " "
      
      new_hash[:external_id] = line[:id_user]
      new_hash[:first_name] = line[:nombre]
      new_hash[:last_name] = line[:apellidos]
      new_hash[:edad] = line[:edad]
      new_hash[:phone] = line[:telefono1_]
      
      
      # ENCODING IS A MADNESS, CONFIDENCE 100 IS NOT NEITHER ENOUGH
      # if !codifications.include? detection_external_id[:encoding]
        # if detection_external_id[:confidence] > 60
          # new_hash[:external_id] = converter.convert line[:id_user], detection_external_id[:encoding], 'UTF-8'
        # end
      # end
      
      # if !codifications.include? detection_first_name[:encoding]
        # if detection_first_name[:confidence] > 60
          # new_hash[:first_name] = converter.convert line[:nombre], detection_first_name[:encoding], 'UTF-8'
        # end
      # end
      # if !codifications.include? detection_last_name[:encoding]
        # if detection_last_name[:confidence] > 60
          # new_hash[:last_name] = converter.convert line[:apellidos], detection_last_name[:encoding], 'UTF-8'
        # end
      # end
      # if !codifications.include? detection_edad[:encoding]
        # if detection_edad[:confidence] > 60
          # new_hash[:edad] = converter.convert line[:edad], detection_edad[:encoding], 'UTF-8'
        # end
      # end
      # if !codifications.include? detection_phone[:encoding]
        # if detection_phone[:confidence] > 60
          # new_hash[:phone] = converter.convert line[:telefono1_], detection_phone[:encoding], 'UTF-8'
        # end
      # end
      
      
      
      
      # if detection_external_id[:encoding] != 'UTF-8'
        # new_hash[:external_id] =  line[:id_user].decode(detection_external_id[:encoding])
      # end
      
      # if detection_first_name[:encoding] != 'UTF-8'
        # new_hash[:first_name] = line[:nombre].decode(detection_first_name[:encoding])
      # end
      # if detection_last_name[:encoding] != 'UTF-8'
        # new_hash[:last_name] = line[:apellidos].decode(detection_last_name[:encoding])
      # end
      # if detection_edad[:encoding] != 'UTF-8'
        # new_hash[:edad] = line[:edad].decode(detection_edad[:encoding])
      # end
      # if detection_phone[:encoding] != 'UTF-8'
        # new_hash[:phone] = line[:telefono1_].decode(detection_phone[:encoding])
      # end
      
      error_string += "Phone is not valid on line #{counter.to_s}" if !OriginSale.is_valid_phone?(new_hash[:phone])
      error_string += "\nFirst Name is not valid on line #{counter.to_s}" if !(/^[\p{L} '-.]+$/i === new_hash[:first_name])
      error_string += "\nLast Name is not valid on line #{counter.to_s}" if !(/^[\p{L} '-.]+$/i === new_hash[:last_name])
      # error_string += "\nCity is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:city])
      # error_string += "\nProvince is not valid on line #{counter.to_s}" if !(/^[\p{L} ']+$/i === line[:province])
      error_string += "\nID_user is not valid on line #{counter.to_s}" if !(/^[\p{N}]+$/i === new_hash[:external_id])
      error_string += "\nCP is not valid on line #{counter.to_s}" if !(/^[\p{N}]+$/i === cp)
      error_string += "\nEdad is not valid on line #{counter.to_s}" if !(/^[\p{N}]+$/i === new_hash[:edad])
      
      new_hash[:province] = province.name
      new_hash[:postal_code] = cp
      new_hash[:city] = " "
      new_hash[:external_id] = ht.encode(new_hash[:external_id], :named)
      new_hash[:edad] = ht.encode(new_hash[:edad], :named)
      new_hash[:first_name] = ht.encode(new_hash[:first_name], :named)
      new_hash[:last_name] = ht.encode(new_hash[:last_name], :named)
      new_hash[:street] = " "
      new_hash[:email] = " "
      line_partial = new_hash.merge(include_fields)
      
      
      origin = OriginSale.first(line_partial.to_hash)
      include_fields[:user] = un
      hash_to_import = line_partial.merge(include_fields)
      
      detection_external_id = detection_first_name = detection_last_name = detection_edad = detection_phone = nil
      
      
      if origin.nil?
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
          origin_sale = OriginSale.new(hash_to_import.to_hash)
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
      if !self.file_name.nil? && !self.file_name.empty?
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
