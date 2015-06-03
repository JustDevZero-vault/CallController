class CallController < Sinatra::Application
 
  before /^(\/campaign)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  #~ get '/campaign/types' do
    #~ @campaign_types = Campaign_Types.all()
    #~ erb :'campaign'
  #~ end
  
  #~ get '/campaign/type/add' do
    #~ erb :'campaign_add'
  #~ end
  
  #~ get '/campaign/type/edit/:id' do
    #~ @campaign = Campaign.first(:id => params['id'])
    #~ erb :'campaign_edit'
  #~ end
  
  post '/campaign/type/add' do
#    type = CampaignType.first(:name => params['name'])
    
#    if type.nil?
      CampaignType.first_or_create(:name => params['name'])
#    end
    campaignlist = '/campaigns'
    redirect to campaignlist
  end
  
  post '/campaign/type/edit' do
    type = CampaignType.first(:id => params['id'])
    
    if !type.nil?
      type.update(:name => params['name'])
    end
    campaignlist = '/campaigns'
    redirect to campaignlist
  end
  
  
  post '/campaign/type/del' do
    typ = CampaignType.first(:name => params['name'])
    
    if !typ.nil?
      #~ campaign = Campaign.all(:campaign_type => typ)
      #~ if !campaign.nil?
        #~ campaign.destroy
        #~ campaign.reload
      #~ end
      typ.destroy
      typ.reload
    else
    end
    campaignlist = '/campaigns'
    redirect to campaignlist
  end
  
end
