class CallController < Sinatra::Application
  get '/' do
    if user.is_admin?
      erb :admin_dashboard
    else
      erb :dashboard
    end
  end
end
