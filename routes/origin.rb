class CallController < Sinatra::Application

  before /^(\/origin)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/origin/campaign/:campaign_id' do
    erb :'origin_campaign'
  end
    
  get '/origin/edit/:origin_id' do
    erb :'origin_edit'
  end

  post '/origin' do
    @origins = Origin.all(:campaign_id => (params['campaign_id']) )
    erb :'origin_campaign'
  end
  
  post '/origin/edit' do
      sale = Sale.first(:id => (params['id']) )
      un = User.first(:id => (session[:username]) )
      if !sale.nil?
        params.each do |key, value|
          sale.update(key => html_escape(value))
          next
        end
        sale.update(modified_by = user.id)
        sale.update(modified_at = Time.now)
        sale.save
        sale.reload
      end
      origins = '/origin/campaign' + sale.campaign_id
      redirect to origins
  end

  post '/origin/add' do
      origin = OriginDatabase.first(:id => (param['external_id']) )
      if !origin.nil?
          OriginDatabase.create(params)
      end
      redirect to '/campaign'
  end

end
