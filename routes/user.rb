class CallController < Sinatra::Application
  before /^(\/user)/ do
    unless user.is_admin?
      redirect "/"
    end
  end

  get '/users' do
    @users = User.all
    @roles = Role.all
    erb :'user/users_overview'
  end

  post '/user/add' do
    User.new(params['username'], params['email'], params['password'])
    userlist = '/users'
    redirect to userlist
  end

  post '/user/edit' do
    un = User.first(:username => params['username'])
    if !params['active'].nil?
      un.update(:active => true)
    else
      un.update(:active => false)
    end
    if params['first_name'] != ""
      un.update(:first_name => params['first_name'])
    end
    if params['last_name'] != ""
      un.update(:last_name => params['last_name'])
    end
    if params['email'] != ""
      un.update(:email => params['email'])
    end
    if params['password'] != ""
      enc_pw = BCrypt::Password.create(params['password'])
      un.update(:password => enc_pw)
    end
    userlist = '/users'
    redirect to userlist
  end

  post '/user/del' do
    unless user.is_admin?
      halt 403
    end
    un = User.first(:username => params['username'])
    un.role_members.all.destroy
    un.reload
    un.destroy
    userlist = '/users'
    redirect to userlist
  end

  get "/password/request" do
    erb :'user/password_request', :layout => false
  end

  post "/password/request" do
    email = params['email'].downcase
    un = User.first(:email => email)
    if !un.nil?
      elapsed_time = Time.now - un.updated_at
      if ( elapsed_time.to_s.to_i > 300 )
        newtoken = SecureRandom.urlsafe_base64
        un.update(:token => newtoken)
        base_url = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
        reset_path = "#{base_url}/password/reset/#{newtoken}"
        Email.mail(email, "Password recovery", "Hello #{un.username},\nClick to Reset Your Password:\n #{reset_path}")
        un.updated_at = Time.now
        un.save
        un.reload
        erb "An email was sent to #{params[:email]} to recover your password."
      else
        erb "<div class='alert alert-error'>"+t('token.wait')+"</div>"
      end
    else
      erb "<div class='alert alert-error'>"+t('error.email.invalid')+"</div>"
    end
  end

  get "/password/reset/:token" do
    if !params[:token].nil?
      un = User.first(:token => (params['token']))
      if !un.nil?
        erb :'user/password_reset', :layout => false, :locals => {:token => params['token']}
      else
        erb "<div class='alert alert-error'>"+t('token.invalid') + params['token'] +"</div>"
      end
    else
      halt 401
    end
  end

  post "/password/reset" do
    if !params['token'].nil?
      un = User.first(:token => (params['token']) )
      if !un.nil?
        if un.username == params['username']
          if params['confirm_password'] == params['password']
            encpw = BCrypt::Password.create(params['password'])
            un.password = encpw
          else
            erb t('password.match')
          end
        else
          halt 403
        end
        un.token = nil
        un.updated_at = Time.now
        un.save
        un.reload
        redirect '/'
      else
        erb "<div class='alert alert-error'>"+t('token.invalid')+"</div>"
      end
    else
      halt 401
    end
  end

  get "/password/change" do
    erb :'user/password_change'
  end

  post "/password/change" do
    un = User.first(:username => (session[:username]))
    if un.password == params['password']
      if params['new_password'] == params['confirm_password']
        un.password = BCrypt::Password.create(params['new_password'])
        un.updated_at = Time.now
        un.save
        un.reload()
        erb "<div class='alert alert-info'>"+t('action.saved')+"</div>"
      else
        erb "<div class='alert alert-error'>"+t('password.match')+"</div>"
      end
    else
      erb "<div class='alert alert-error'>"+t('password.wrong')+"</div>"
    end
  end

  get "/users/:user/notifications/:action" do
    user = User.first(:username => params[:user])
    if params[:action] == "enable"
      user.receive_notifications = true
      user.save
    elsif params[:action] == "disable"
      user.receive_notifications = false
      user.save
    end
    redirect to '/users'
  end

end
