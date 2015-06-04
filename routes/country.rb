# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
 
  before /^(\/country)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/countries' do
    @countries = Country.all()
    erb :'countries_overview'
  end
   
  post '/country/add' do
  ht = HTMLEntities.new
    Country.create(
      :name => ht.encode(params['nombre'], :named),
      :name => ht.encode(params['name'], :named),
      :nom => ht.encode(params['nom'], :named),
      :iso2 => ht.encode(params['iso2'], :named),
      :iso3 => ht.encode(params['iso3'], :named),
      :phone_code => ht.encode(params['phone_code'], :named)
      )
    redirect to '/countries'
  end
  
  post '/country/del' do
    cn = Country.first(:id => params['delete_country_id'])
    cn.destroy
    redirect to '/countries'
  end
  
  post '/country/edit' do
    country = Country.first(:id => params['id'])
    if !country.nil?
      country.update(:name => ht.encode(params['nombre'], :named)) if params['nombre'].nil?
      country.update(:name => ht.encode(params['name'], :named)) if params['name'].nil?
      country.update(:name => ht.encode(params['nom'], :named)) if params['nom'].nil?
      country.update(:name => ht.encode(params['iso2'], :named)) if params['iso2'].nil?
      country.update(:name => ht.encode(params['iso3'], :named)) if params['iso3'].nil?
    end
    redirect to '/countries'
  end
  
  post '/country/migrate' do
      #~ Thread.new do
        Country.begin_migrate
      #~ end
    # redirect to '/countries'
  end
    
end
