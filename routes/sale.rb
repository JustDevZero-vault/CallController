# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  get '/sale/edit/:id' do
      un = User.first(:username => (session[:username]) )
      if un.is_agent?
        sale = Sale.first(:id => (params['id']) )
      end
      erb :'sale_edit'
  end
  
  get '/sale/next' do
      results = CallResult.all(:code => ['3', '15'] )
      user_name = session[:username]
      un = User.first(:username => user_name )
      if un.is_agent?
        queue_member = QueueMembers.first(:user_id => user)
        users = User.all(:username => ['queue', user_name] )
        @unmanaged_sales = Sale.all(:user => users, , :campaign.active => true, :result => results, :order => [:id.asc] )
      end
      erb :'sale_edit'
  end

  post '/sale/edit' do
    sale = Sale.first(:id => (params['edit_sale_id']) )
    un = User.first(:username => (session[:username]) )
    user_queue = User.first(:username => 'queue')
    if ((un.is_agent? && sale.user.id == un.id) || (un.is_agent? && sale.user.id == user_queue.id) || un.is_admin? || un.is_supervisor? || un.is_manager? || un.is_coacher?)
      if !sale.nil?
          
        sale.update(:user => un) if un.is_agent?
        call_result = CallResult.first(:id => params['edit_sale_call_result_id'])
        sale.update(:call_result => call_result)
        
        if !params['edit_sale_callback_date'].nil? && !params['edit_sale_callback_date'].empty? && !call_result.nil? && call_result.is_callback == true
          sale.update(:callback_date => params['edit_sale_callback_date'].to_datetime)
        else
          sale.callback_date = ''
        end
        sale.update(:user => user_queue) if !params['return_to_main_queue'].nil?
        sale.update(:call_date => Date.today.to_datetime)
        sale.save
        sale.reload
      end
    end
    redirect to '/sales'
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
  
  # get '/sales' do
    # un = User.first(:id => (session[:username]) )
    # if !un.nil?
      # @sales = Sale.all(:user_id => user.id)
      # sale_ids = @sales.all(:fields => 'id').to_a
      # @comments = Comment.all(:sale_id => sale_ids )
      # erb :'sale_list'
    # end
  # end
  
end
