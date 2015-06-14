# -*- coding: utf-8 -*-
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
    ht = HTMLEntities.new
    campaign_type = CampaignType.first_or_create(:name => ht.encode(params['name'], :named))
    redirect to '/campaigns'
  end
  
  post '/campaign/type/edit' do
    ht = HTMLEntities.new
    type = CampaignType.first(:id => params['edit_campaign_id'])
    type.update(:name => ht.encode(params['edit_campaign_type_name'], :named)) if !type.nil? && !params['edit_campaign_id'].empty?
    type.save
    type.reload
    redirect to '/campaigns'
  end
  
  
  post '/campaign/type/del' do
    typ = CampaignType.first(:id => params['del_campaign_type_id'])
    
    if !typ.nil?
      typ.campaigns.all.destroy
      typ.reload
      typ.destroy 
    end
    redirect to '/campaigns'
  end
  
end
