class CallController < Sinatra::Application
 
  before /^(\/campaign)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/campaign/types' do
    @campaign_types = Campaign_Types.all()
    erb :'campaign'
  end
  
  get '/campaign/type/add/' do
    erb :'campaign_add'
  end
  
  get '/campaign/type/edit/:id' do
    @campaign = Campaign.first(:id => params['id'])
    erb :'campaign_edit'
  end
  
  post '/campaign/add' do
    campaign = Campaign.first(:external_id => params['external_id'])
    
    if campaign.nil?
      campaign.create(:name => params['name'])
    end
    campaignlist = '/campaign/types'
    redirect to campaignlist
  end
  
  post '/campaign/types/edit' do
    campaign = Campaign.first(:id => params['id'])
    
    if !campaign.nil?
        
        if params['active'].nil?
          campaign.active = false
        else
          campaign.active = true
        end
        
        if params['external_id'].nil?
            campaign.external_id = params['campaign_type']
        end
        
        if params['campaign_type'].nil?
            campaign.campaign_type = params['campaign_type']
        end
        
        campaign.updated_at = Time.now
        campaign.save
        campaign.reload
    end
    campaignlist = '/campaign'
    redirect to campaignlist
  end
  
end
