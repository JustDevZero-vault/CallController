# -*- coding: utf-8 -*-
class Province
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :code, String, :length => 2
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :country, :model => Country
  
  def self.spanish_begin_migrate
    spain = Country.first(:iso_code => 'ES')
    first_or_create(:country => spain, :code => '01', :name => CGI::escapeHTML(Rack::Utils.escape_html('Araba')))
    first_or_create(:country => spain, :code => '02', :name => CGI::escapeHTML(Rack::Utils.escape_html('Albacete')))
    first_or_create(:country => spain, :code => '03', :name => CGI::escapeHTML(Rack::Utils.escape_html('Alicante')))
    first_or_create(:country => spain, :code => '04', :name => CGI::escapeHTML(Rack::Utils.escape_html('Almería')))
    first_or_create(:country => spain, :code => '05', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ávila')))
    first_or_create(:country => spain, :code => '06', :name => CGI::escapeHTML(Rack::Utils.escape_html('Badajoz')))
    first_or_create(:country => spain, :code => '07', :name => CGI::escapeHTML(Rack::Utils.escape_html('Islas Baleares')))
    first_or_create(:country => spain, :code => '08', :name => CGI::escapeHTML(Rack::Utils.escape_html('Barcelona')))
    first_or_create(:country => spain, :code => '09', :name => CGI::escapeHTML(Rack::Utils.escape_html('Burgos')))
    first_or_create(:country => spain, :code => '10', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cáceres')))
    first_or_create(:country => spain, :code => '11', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cádiz')))
    first_or_create(:country => spain, :code => '12', :name => CGI::escapeHTML(Rack::Utils.escape_html('Castellón')))
    first_or_create(:country => spain, :code => '13', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ciudad Real')))
    first_or_create(:country => spain, :code => '14', :name => CGI::escapeHTML(Rack::Utils.escape_html('Córdoba')))
    first_or_create(:country => spain, :code => '15', :name => CGI::escapeHTML(Rack::Utils.escape_html('A Coruña')))
    first_or_create(:country => spain, :code => '16', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cuenca')))
    first_or_create(:country => spain, :code => '17', :name => CGI::escapeHTML(Rack::Utils.escape_html('Girona')))
    first_or_create(:country => spain, :code => '18', :name => CGI::escapeHTML(Rack::Utils.escape_html('Granada')))
    first_or_create(:country => spain, :code => '19', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guadalajara')))
    first_or_create(:country => spain, :code => '20', :name => CGI::escapeHTML(Rack::Utils.escape_html('Gipuzkoa')))
    first_or_create(:country => spain, :code => '21', :name => CGI::escapeHTML(Rack::Utils.escape_html('Huelva')))
    first_or_create(:country => spain, :code => '22', :name => CGI::escapeHTML(Rack::Utils.escape_html('Huesca')))
    first_or_create(:country => spain, :code => '23', :name => CGI::escapeHTML(Rack::Utils.escape_html('Jaén')))
    first_or_create(:country => spain, :code => '24', :name => CGI::escapeHTML(Rack::Utils.escape_html('León')))
    first_or_create(:country => spain, :code => '25', :name => CGI::escapeHTML(Rack::Utils.escape_html('Lleida')))
    first_or_create(:country => spain, :code => '26', :name => CGI::escapeHTML(Rack::Utils.escape_html('La Rioja')))
    first_or_create(:country => spain, :code => '27', :name => CGI::escapeHTML(Rack::Utils.escape_html('Lugo')))
    first_or_create(:country => spain, :code => '28', :name => CGI::escapeHTML(Rack::Utils.escape_html('Madrid')))
    first_or_create(:country => spain, :code => '29', :name => CGI::escapeHTML(Rack::Utils.escape_html('Málaga')))
    first_or_create(:country => spain, :code => '30', :name => CGI::escapeHTML(Rack::Utils.escape_html('Murcia')))
    first_or_create(:country => spain, :code => '31', :name => CGI::escapeHTML(Rack::Utils.escape_html('Navarre')))
    first_or_create(:country => spain, :code => '32', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ourense')))
    first_or_create(:country => spain, :code => '33', :name => CGI::escapeHTML(Rack::Utils.escape_html('Asturias')))
    first_or_create(:country => spain, :code => '34', :name => CGI::escapeHTML(Rack::Utils.escape_html('Palencia')))
    first_or_create(:country => spain, :code => '35', :name => CGI::escapeHTML(Rack::Utils.escape_html('Las Palmas')))
    first_or_create(:country => spain, :code => '36', :name => CGI::escapeHTML(Rack::Utils.escape_html('Pontevedra')))
    first_or_create(:country => spain, :code => '37', :name => CGI::escapeHTML(Rack::Utils.escape_html('Salamanca')))
    first_or_create(:country => spain, :code => '38', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sta. Cruz de Tenerife')))
    first_or_create(:country => spain, :code => '39', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cantabria')))
    first_or_create(:country => spain, :code => '40', :name => CGI::escapeHTML(Rack::Utils.escape_html('Segovia')))
    first_or_create(:country => spain, :code => '41', :name => CGI::escapeHTML(Rack::Utils.escape_html('Seville')))
    first_or_create(:country => spain, :code => '42', :name => CGI::escapeHTML(Rack::Utils.escape_html('Soria')))
    first_or_create(:country => spain, :code => '43', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tarragona')))
    first_or_create(:country => spain, :code => '44', :name => CGI::escapeHTML(Rack::Utils.escape_html('Teruel')))
    first_or_create(:country => spain, :code => '45', :name => CGI::escapeHTML(Rack::Utils.escape_html('Toledo')))
    first_or_create(:country => spain, :code => '46', :name => CGI::escapeHTML(Rack::Utils.escape_html('Valencia')))
    first_or_create(:country => spain, :code => '47', :name => CGI::escapeHTML(Rack::Utils.escape_html('Valladolid')))
    first_or_create(:country => spain, :code => '48', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bizkaia')))
    first_or_create(:country => spain, :code => '49', :name => CGI::escapeHTML(Rack::Utils.escape_html('Zamora')))
    first_or_create(:country => spain, :code => '50', :name => CGI::escapeHTML(Rack::Utils.escape_html('Zaragoza')))
    first_or_create(:country => spain, :code => '51', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ceuta')))
    first_or_create(:country => spain, :code => '52', :name => CGI::escapeHTML(Rack::Utils.escape_html('Melilla')))
  end

end
