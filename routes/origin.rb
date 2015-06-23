# -*- coding: utf-8 -*-
class CallController < Sinatra::Application

  before /^(\/origin)/ do
    unless !user.nil? && (user.is_admin? || user.is_manager?)
      redirect "/"
    end
  end
  
  #~ get '/origin/campaign/:campaign_id' do
    #~ erb :'origin_campaign'
  #~ end
    #~ 
  #~ get '/origin/edit/:origin_id' do
    #~ erb :'origin_edit'
  #~ end

  #~ get '/origin' do
    #~ @origins = OriginSale.all(:campaign_id => (params['campaign_id']) )
    #~ erb :'origin_campaign'
  #~ end

  get '/origin/failed/:id' do
    @origins = OriginSale.all(:campaign_id => (params[:id]), :review => true )
    erb :'origin_failed'
  end
  
  post '/origin/edit' do
      sale = OriginSale.first(:id => (params['origin_id']) )
      un = User.first(:id => (session[:username]) )
      params.delete('origin_id')
      ht = HTMLEntities.new
      if !sale.nil?
        params.each_pair do |key, value|
          sale.update(key => ht.encode(value, :named))
          next
        end
        sale.update(:review => false)
        sale.save
        sale.reload
      end
      
      redirect_value = '/campaigns'
      reviews = OriginSale.all(:review => true)
      if reviews.count > 0
        redirect_value = '/origin/failed' + sale.campaign_id
      end
      redirect to redirect_value
  end

  post '/origin/add' do
      origin = OriginDatabase.first(:id => (param['external_id']) )
      if !origin.nil?
          OriginDatabase.create(params)
      end
      redirect to '/campaign'
  end

end
