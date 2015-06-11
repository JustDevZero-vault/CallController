class CallController < Sinatra::Application
  before /^(\/queue)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  
  post '/queue/add' do
    ht = HTMLEntities.new
    queue = CallQueue.first_or_create(:name => ht.encode(params['name'], :named))
    userlist = '/users'
    redirect to userlist
  end

  #~ get '/queue/edit/:role' do
    #~ @role = Role.first(:name => params[:role])
    #~ erb :'user/edit_role', :layout => false
  #~ end

  #~ post '/role/edit' do  ## TODO
    #~ role = Role.first(:name => params['name'])
    #~ userlist = '/users'
    #~ redirect to userlist
  #~ end

  post '/queue/member/add' do
    queue = CallQueue.first(:id => params['queue_id'])
    un = User.first(:id => params['user_id'])
    role.add_member(un)
  end

  post '/queue/member/del' do
    queue = CallQueue.first(:id => params['queue_id'])
    un = User.first(:id => params['user_id'])
    queue.del_member(un)
  end

  post '/queue/del' do
    queue = CallQueue.first(:id => params['queue_del_id'])
    queue.queue_members.all.destroy
    queue.reload
    queue.destroy
    redirect to '/users'
  end
end
