class CallController < Sinatra::Application
 
  before /^(\/campaign)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/campaigns' do
    @campaigns = Campaign.all()
    @campaigntypes = CampaignType.all()
    erb :'campaign/overview'
  end
  
  get '/campaign/upload/:id' do
    @campaign_id = params[:id]
    erb :'campaign/upload'
  end
  
  post '/campaign/activate' do
    cp = Campaign.first(:id => params['id'])
    if !cp.nil?
      if params['campaign_state'] === '1'
        cp.update(:active => true)
      else
        cp.update(:active => false)
      end
    end
  end  
  
  post '/campaign/add' do
    
    type = CampaignType.first(:id => params['campaigntype'])
    cp = Campaign.first(:external_id => params['external'])
    if cp.nil?
      Campaign.create(:external_id => params[:external], :campaign_type => type)
    end
    
    campaignlist = '/campaigns'
    redirect to campaignlist
  end
  
  post '/campaign/del' do
    cpg = Campaign.first(:external_id => params['external_del_id'])
    cpg.destroy
    campaignlist = '/campaigns'
    redirect to campaignlist
  end
  
  post '/campaign/edit' do
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
    campaignlist = '/campaigns'
    redirect to campaignlist
  end
  
  post '/campaign/upload' do
    campaign = Campaign.first(:id => params['campaign_id'])
    if !campaign.nil?
        year_month_day = Time.now.strftime("%Y/%m/%d")
        year_month_day_folder = 'public/uploads/imports/' + year_month_day + '/'
        
        FileUtils.mkdir_p(year_month_day_folder)  unless File.exists?(year_month_day_folder)
        File.open( year_month_day_folder + params['file'][:filename], "w") do |campaign_file|
          campaign_file.write(params['file'][:tempfile].read) 
        end
        final_file = year_month_day_folder + params['file'][:filename]
      campaign.update(:file_name => final_file)
     else
    end
    redirect to '/campaigns'
  end
  
  post '/campaign/import' do
    cn = Campaign.first(:id => params['campaign_id'])
    un = User.first(:username => session['username'])

    if !cn.nil?
      #~ CampaignInstance.create(campaign.id, un, 'import')
      
       Thread.new do
        cn.process_import(un)
       end
      
    end
    #~ redirect to '/campaigns'
  end
  
end
