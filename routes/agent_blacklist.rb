class CallController < Sinatra::Application
  before /^(\/blacklist)/ do
    unless user.is_admin?
      redirect "/"
    end
  end

  get '/blacklist/users' do
    blacklist = AgentBlacklistMember.all()
    erb :'blacklist_agents'
  end

  #~ post '/blacklist/agent/add' do
    #~ blacklist = AgentBlacklist.first(:conditions => { :user_id => params['user_id'], :campaign_id => params['campaign_id'] })
    #~ if blacklist.nil? && 
      #~ blacklist.create({ :user_id => params['user_id'], :campaign_id => params['campaign_id'] })
      #~ AgentBlacklist
    #~ end
    #~ redirect to '/blacklist/agents'
  #~ end
  
  post '/blacklist/user/add' do
    campaign = Campaign.first(:campaign_id => params['campaign_id'])
    un = User.first(:campaign_id => params['user_id'])
    if campaign.nil? && 
      campaign.blacklist(un)
    end
    redirect to '/blacklist/users'
  end

  post '/blacklist/user/del' do
    blacklist = Campaign.first(:campaign_id => params['campaign_id'])
    un = User.first(:username => params['username'])
    blacklist.delist(un)
    redirect to '/blacklist/users'
  end
  
end