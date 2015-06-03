class Province
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :code, String, :max => 2
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :country, :model => Country
  
  def spanish_migrate
    spain = Country.first(:iso_code => 'ES')
    self.create(:country => spain, :code => '01', :name => 'Araba')
    self.create(:country => spain, :code => '02', :name => 'Albacete')
    self.create(:country => spain, :code => '03', :name => 'Alicante')
    self.create(:country => spain, :code => '04', :name => 'Almería')
    self.create(:country => spain, :code => '05', :name => 'Ávila')
    self.create(:country => spain, :code => '06', :name => 'Badajoz')
    self.create(:country => spain, :code => '07', :name => 'Islas Baleares')
    self.create(:country => spain, :code => '08', :name => 'Barcelona')
    self.create(:country => spain, :code => '09', :name => 'Burgos')
    self.create(:country => spain, :code => '10', :name => 'Cáceres')
    self.create(:country => spain, :code => '11', :name => 'Cádiz')
    self.create(:country => spain, :code => '12', :name => 'Castellón')
    self.create(:country => spain, :code => '13', :name => 'Ciudad Real')
    self.create(:country => spain, :code => '14', :name => 'Córdoba')
    self.create(:country => spain, :code => '15', :name => 'A Coruña')
    self.create(:country => spain, :code => '16', :name => 'Cuenca')
    self.create(:country => spain, :code => '17', :name => 'Girona')
    self.create(:country => spain, :code => '18', :name => 'Granada')
    self.create(:country => spain, :code => '19', :name => 'Guadalajara')
    self.create(:country => spain, :code => '20', :name => 'Gipuzkoa')
    self.create(:country => spain, :code => '21', :name => 'Huelva')
    self.create(:country => spain, :code => '22', :name => 'Huesca')
    self.create(:country => spain, :code => '23', :name => 'Jaén')
    self.create(:country => spain, :code => '24', :name => 'León')
    self.create(:country => spain, :code => '25', :name => 'Lleida')
    self.create(:country => spain, :code => '26', :name => 'La Rioja')
    self.create(:country => spain, :code => '27', :name => 'Lugo')
    self.create(:country => spain, :code => '28', :name => 'Madrid')
    self.create(:country => spain, :code => '29', :name => 'Málaga')
    self.create(:country => spain, :code => '30', :name => 'Murcia')
    self.create(:country => spain, :code => '31', :name => 'Navarre')
    self.create(:country => spain, :code => '32', :name => 'Ourense')
    self.create(:country => spain, :code => '33', :name => 'Asturias')
    self.create(:country => spain, :code => '34', :name => 'Palencia')
    self.create(:country => spain, :code => '35', :name => 'Las Palmas')
    self.create(:country => spain, :code => '36', :name => 'Pontevedra')
    self.create(:country => spain, :code => '37', :name => 'Salamanca')
    self.create(:country => spain, :code => '38', :name => 'Sta. Cruz de Tenerife')
    self.create(:country => spain, :code => '39', :name => 'Cantabria')
    self.create(:country => spain, :code => '40', :name => 'Segovia')
    self.create(:country => spain, :code => '41', :name => 'Seville')
    self.create(:country => spain, :code => '42', :name => 'Soria')
    self.create(:country => spain, :code => '43', :name => 'Tarragona')
    self.create(:country => spain, :code => '44', :name => 'Teruel')
    self.create(:country => spain, :code => '45', :name => 'Toledo')
    self.create(:country => spain, :code => '46', :name => 'Valencia')
    self.create(:country => spain, :code => '47', :name => 'Valladolid')
    self.create(:country => spain, :code => '48', :name => 'Bizkaia')
    self.create(:country => spain, :code => '49', :name => 'Zamora')
    self.create(:country => spain, :code => '50', :name => 'Zaragoza')
    self.create(:country => spain, :code => '51', :name => 'Ceuta')
    self.create(:country => spain, :code => '52', :name => 'Melilla')
  end

end
