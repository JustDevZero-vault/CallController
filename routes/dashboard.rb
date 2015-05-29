class CallController < Sinatra::Application
  get '/' do
    erb :dashboard
  end
end
