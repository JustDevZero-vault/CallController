class CallController < Sinatra::Application
  get '/sale/edit/:id' do
      sale = Sale.first(:id => (params['id']) )
      erb :'sale_edit'
    end
  end

  post '/sale/edit' do
    sale = Sale.first(:id => (params['id']) )
    un = User.first(:id => (session[:username]) )
    if !sale.nil?
      sale.user_id = un.id
      sale.call_type = params['call_type']
      if !params['callback_date'].nil? && params['call_type'] == 13
        sale.callback_date = params['callback_date']
      else
        sale.callback_date = ''
      end
      if !params['return_to_main_queue'].nil?
        sale.enqueued = true
      else
        sale.enqueued = false
      end
      sale.updated_at = Time.now
      sale.updated_by = un.id
      sale.save
      sale.reload
    end
    redirect to '/sales'
  end
  
  get '/sale/comment/add/:sale_id' do
    erb :'sale_comment_add'
  end
  
  post '/sale/comment/add' do
    sale = Sale.first(:id => (session[:username]) )
    un = User.first(:id => (session[:username]))
    if !un.nil?
      sale = Sale.first(:user_id => un.id)
      if !sale.nil?
        Comment.create(:sale_id => params['id'], :name => params['comment'], :author => un.id)
      end
    end
  end
  
  get '/sales' do
    un = User.first(:id => (session[:username]) )
    if !un.nil?
      @sales = Sale.all(:user_id => user.id)
      sale_ids = @sales.all(:fields => 'id').to_a
      @comments = Comment.all(:sale_id => sale_ids )
      erb :'sale_list'
    end
  end
end
