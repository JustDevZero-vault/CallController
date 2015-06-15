# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
 
  before /^(\/campaign)/ do
    unless user.is_admin? || user.is_manager?
      redirect "/"
    end
  end
  
  get '/campaigns' do
    @campaigns = Campaign.all()
    @campaigntypes = CampaignType.all()
    @call_queues = CallQueue.all()
    erb :'campaign/overview'
  end
  
  get '/campaign/upload/:id' do
    @campaign_id = params[:id]
    erb :'campaign/upload'
  end
  
  post '/campaign/purge' do
    cp = Campaign.first(:external_id => params['external_purge_id'])
    sales = Sale.all(:campaign => cp)
    origins = OriginSale.all(:campaign => cp)
    #sales.comment.all.destroy
    sales.destroy
    origins.destroy
    cp.update(:parsed => 'unparsed')
    cp.update(:processed => 'unprocessed')
    cp.save
    cp.reload
    redirect to '/campaigns'
  end
  
  post '/campaign/activate' do
    cp = Campaign.first(:id => params['id'])
    if !cp.nil?
      if params['campaign_state'] === '1'
        cp.update(:active => true)
      else
        cp.update(:active => false)
      end
      cp.save
      cp.reload
    end
  end  
  
  post '/campaign/add' do
    
    type = CampaignType.first(:id => params['campaigntype'])
    cp = Campaign.first(:external_id => params['external'])
    call_queue = CallQueue.first(:id => params['call_queue'])
    if cp.nil? && !call_queue.nil? && !type.nil?
      Campaign.create(:external_id => params[:external], :campaign_type => type, :call_queue => call_queue)
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
    campaign = Campaign.first(:id => params['campaign_id_edit'].to_i)
    
    if !campaign.nil?
      campaign.update(:external_id => params['external_edit']) if !params['external_edit'].nil?
      
      if !params['campaigntype_edit'].nil?
        campaign_type = CampaignType.first(:id => params['campaigntype_edit'])
        campaign.update(:campaign_type => campaign_type)
      end
      
      if !params['call_queue_edit'].nil?
        call_queue = CallQueue.first(:id => params['call_queue_edit'])
        campaign.update(:call_queue => call_queue)
      end
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
        if !!!( final_file =~ /.fixed.csv$/)
          campaign.update(:file_name => final_file)
        end
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
  
  post '/campaign/process' do
    cn = Campaign.first(:id => params['campaign_id'])

    if !cn.nil?
      #~ CampaignInstance.create(campaign.id, un, 'import')
      
       Thread.new do
        cn.migrate_to_sales
       end
      
    end
    #~ redirect to '/campaigns'
  end
  
end
