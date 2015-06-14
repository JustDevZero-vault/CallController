# -*- coding: utf-8 -*-
class Province
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :code, String, :length => 2
  property :postal_code, String, :length => 40
  property :name, String, :length => 255
  property :phone_code, String, :length => 3
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :country, :model => Country
  
  def self.begin_migrate(iso_wanted)
    country = Country.first(:iso2 => iso_wanted )

    ht = HTMLEntities.new
    province_file = "templates/provinces_" << iso_wanted.downcase << ".csv"
    if !country.nil? && File.exist?(province_file)
      CSV.foreach(province_file,
                :headers           => true,
                :header_converters => :symbol,
                ) do |line|
        province = first(:code => line[:code])
        newline = {
          :code => ht.encode(line[:code], :named),
          :postal_code => ht.encode(line[:postal_code], :named),
          :name => ht.encode(line[:name], :named),
          :phone_code => ht.encode(line[:phone_code], :named),
          :country => country,
          }
        if province.nil?
          #~ begin
            create(newline)
          #~ rescue DataMapper::SaveFailureError => e
            #~ Notification.create(:type => :error, :sticky => false, :message => "Error creating province: #{e.to_s} validation: #{errors.values.join(', ')}")
          #~ rescue StandardError => e
            #~ Notification.create(:type => :error, :sticky => false, :message => "Got an error trying to create province #{e.to_s}")
          #~ end
        else
          #~ begin
            province.update(newline)
          #~ rescue DataMapper::SaveFailureError => e
            #~ Notification.create(:type => :error, :sticky => false, :message => "Error updating province: #{e.to_s} validation: #{errors.values.join(', ')}")
          #~ rescue StandardError => e
            #~ Notification.create(:type => :error, :sticky => false, :message => "Got an error trying to update province #{e.to_s}")
          #~ end
        end
      end
    else
     noti =  Notification.create(:type => :error, :sticky => false, :message => "Missing country or country file")
    end
    country = nil
    newline = nil
  end

end
