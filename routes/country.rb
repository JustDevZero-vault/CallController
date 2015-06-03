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
    Country.create(:external_id => params[:iso_code], :name => CGI::escapeHTML(Rack::Utils.escape_html(params['name'])))
    redirect to '/countries'
  end
  
  post '/country/del' do
    cn = Country.first(:id => params['id'])
    cn.destroy
    redirect to '/countries'
  end
  
  post '/country/edit' do
    country = Country.first(:id => params['id'])
    if !country.nil?
      if params['iso_code'].nil?
        country.update(:iso_code => param['iso_code'])
      end
      if params['name'].nil?
        country.update(:name => CGI::escapeHTML(Rack::Utils.escape_html(param['name'])))
      end
    end
    redirect to '/countries'
  end
  
  post '/country/migrate' do
      Thread.new do
        Country.begin_migrate
      end
    # redirect to '/countries'
  end
    
end
