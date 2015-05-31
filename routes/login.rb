class CallController < Sinatra::Application
  get '/login' do
    status 200
    if !File.exist? '.installed'
      redirect '/setup'
    end
    erb :'user/login', :layout => false
  end

  post '/login' do
    status 200
    u = User.auth(params['username'], params['password'])
    if u
      session[:username] = u.username
      redirect '/'
    else
      @error = "Username or password is wrong"
      erb :'user/login', :layout => false
    end
  end

  get '/logout' do
    status 200
    session.delete(:username)
    erb "<div class='alert alert-message'>Logged out</div>"
  end
end
