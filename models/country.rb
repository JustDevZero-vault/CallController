# -*- coding: utf-8 -*-
class Country
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :nombre, String, :length => 255
  property :name, String, :length => 255
  property :nom, String, :length => 255
  property :iso2, String, :length => 2
  property :iso3, String, :length => 3
  property :phone_code, String
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :provinces
  
  def self.begin_migrate
    ht = HTMLEntities.new
    CSV.foreach("templates/countries.csv",
                :headers           => true,
                :header_converters => :symbol,
                :converters => :numeric
                ) do |line|
      country = first(:iso2 => line[:iso2])
      newline = {
        :nombre => ht.encode(line[:nombre], :named),
        :name => ht.encode(line[:name], :named),
        :nom => ht.encode(line[:nom], :named),
        :iso2 => ht.encode(line[:iso2], :named),
        :iso3 => ht.encode(line[:iso3], :named),
        :phone_code => ht.encode(line[:phone_code], :named)
        }
      if country.nil?
        create(newline)
      else
        country.update(newline)
      end
      country = nil
      newline = nil
    end
  end
end

