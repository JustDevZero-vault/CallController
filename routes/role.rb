# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  before /^(\/role)/ do
    unless user.is_admin?
      redirect "/"
    end
  end

  post '/role/add' do
    role = Role.first_or_create(:name => params['name'], :capabilities => params['capability'])
    userlist = '/users'
    redirect to userlist
  end

  get '/role/edit/:role' do
    @role = Role.first(:name => params[:role])
    erb :'user/edit_role', :layout => false
  end

  post '/role/edit' do  ## TODO
    role = Role.first(:id => params['role_id'])
    userlist = '/users'
    redirect to userlist
  end

  post '/role/member/add' do
    role = Role.first(:name => params['role'])
    un = User.first(:username => params['username'])
    role.add_member(un)
  end

  post '/role/member/del' do
    role = Role.first(:name => params['role'])
    un = User.first(:username => params['username'])
    role.del_member(un)
  end

  post '/role/del' do
    unless user.is_admin?
      halt 403
    end
    role = Role.first(:id => params['del_role_id'])
    role.role_members.all.destroy
    role.reload
    role.destroy
    redirect to '/users'
  end
end
