class CallController < Sinatra::Application
  get '/' do
    unless user.is_admin?
      erb :dashboard
    else
      erb :admin_dashboard
    end
  end
end
