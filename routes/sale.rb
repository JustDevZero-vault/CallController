# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  get '/sale/edit/:id' do
      un = User.first(:username => (session[:username]) )
      user_queue = User.first(:username => 'queue')
        @sale = Sale.first(:id => params[:id] )
        if ((un.is_agent? && @sale.user.id == un.id) || (un.is_agent? && @sale.user.id == user_queue.id) || un.is_admin? || un.is_supervisor? || un.is_manager? || un.is_coacher?)
        @results = CallResult.all(:code.not => 'Undefined')
        @products = Product.all
        if un.is_agent?
          @sale.update(:user => un)
        end
      end
      erb :'sale_edit', :layout => false
  end
  
  
  get '/nosales' do
    erb :'error_page/no_call', :layout => false
  end
  
  get '/sale/next' do
      # results = CallResult.all(:code => ['Undefined', '3', '15'], :order => [:id.desc] )
      results = CallResult.all(:code => ['3', '15', 'Undefined'] )
      redirect_value = '/nosales'
      user_name = session[:username]
      un = User.first(:username => user_name )
      #~ collection = Sale
      if un.is_agent?
      campaign_collection = []
        queue_member = QueueMember.all(:user => un)
        queue_member.each do |testq|
          campaigns = testq.call_queue.campaigns
          campaigns.each do |campaign|
            campaign_collection << campaign if campaign.active
          end
        end
        users = User.all(:username => ['queue', user_name] )
        if !campaign_collection.nil?
          unmanaged_sale = Sale.first(:user => users, :call_result => results, :campaign=> campaign_collection, :order => [:call_back_date.desc, :id.asc ], :call_back_date.lte => DateTime.now )
          unmanaged_sale = Sale.first(:user => users, :call_result => results, :campaign=> campaign_collection, :order => [:call_back_date.desc, :id.asc ], :call_back_date => nil ) if unmanaged_sale.nil?
          redirect_value = '/sale/edit/' + unmanaged_sale.id.to_s if !unmanaged_sale.nil?
        end
      end
      redirect to redirect_value
      # erb "test", :layout => false
      
  end

  post '/sale/edit' do
    sale = Sale.first(:id => (params['edit_call_id']) )
    un = User.first(:username => (session[:username]) )
    user_queue = User.first(:username => 'queue')
    if ((un.is_agent? && sale.user.id == un.id) || (un.is_agent? && sale.user.id == user_queue.id) || un.is_admin? || un.is_supervisor? || un.is_manager? || un.is_coacher?)
      if !sale.nil?
          
        sale.update(:user => un) if un.is_agent?
        call_result = CallResult.first(:code => params['edit_call_result_code'])
        sale.update(:call_result => call_result) if !call_result.nil?
        product = Product.first(:external_id => params['edit_product_external_id'])
        sale.update(:product => product) if !product.nil? && params['edit_call_result_code'] == "13" 
        
        if !params['edit_call_callback_date'].nil? && !params['edit_call_callback_date'].empty? && !call_result.nil? && (params['edit_call_result_code'] == "3" || params['edit_call_result_code'] == "15")
          #~ sale.update(:call_back_date => params['edit_call_callback_date'].to_datetime.strftime('%Y-%m-%d %H:%M%S').to_datetime)
          captured_date = params['edit_call_callback_date'].to_datetime
          if captured_date.past?
              sale.update(:call_back_date => captured_date) if un.is_admin? || un.is_supervisor? || un.is_manager? || un.is_coacher?
          else
            sale.update(:call_back_date => captured_date)
          end
        elsif params['edit_call_callback_date'].nil? || params['edit_call_callback_date'].empty? && !call_result.nil? && (params['edit_call_result_code'] == "3" || params['edit_call_result_code'] == "15")
          sale.update(:call_back_date => DateTime.now + 3600)
        else
          sale.update(:call_back_date => nil)
        end
        sale.update(:user => user_queue) if !params['return_to_main_queue'].nil? && params['return_to_main_queue'] != "0"
        sale.update(:call_date => DateTime.now)
        sale.save
        sale.reload
      end
    end
    redirect to '/'
  end
  
  get '/sale/:sale_id/comments' do
    erb :'sale_comments'
  end
  
  post '/sale/comment/add' do
    un = User.first(:username => (session[:username]))
    
    if !un.nil?
      sale = Sale.first(:id => (params['new_comment_sale_id']) )
      Comment.create(:sale_id => params['id'], :name => params['comment'], :author => un.id) if !sale.nil?
    end
  end
  
  get '/sales/user/:user' do
    un = User.first(:username => (session[:username]) )
    if !un.nil? && (un.is_admin? || un.is_coacher? || un.is_manager? || un.is_supervisor?)
      chosen_user = User.first(:username => params[:user] )
      @sales = Sale.all(:user => chosen_user)
      erb :'sale_user'
    end
  end
  
end
