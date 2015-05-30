require 'rubygems'
require 'sinatra'

require_relative 'routes/init'
require_relative 'models/init'

class CallController < Sinatra::Application
  configure do
    set :public_folder, Proc.new { File.join(root, "public/") }
    set :bind, '0.0.0.0'
    # set :environment, :production
    enable :sessions
  end

  helpers do
    def user
      if session[:username]
        User.first(:username => session[:username])
      else
        nil
      end
    end
    def timezone
      session[:timezone] ? session[:timezone] : "UTC"
    end
    def t(*args)
      I18n.t(*args)
    end
  end

  before do
    loc = request.env["HTTP_ACCEPT_LANGUAGE"] ? request.env["HTTP_ACCEPT_LANGUAGE"][0,2] : "en"
    I18n.locale = I18n.available_locales.map(&:to_s).include?(loc) ? loc : "en"
  end

  # Check if CallController was installed or user is logged in before doing anything
  before /^(?!\/(setup))(?!\/(login))(?!\/(logout))(^(?!\/(password\/request)))(^(?!\/(password\/reset)))/ do
    if !File.exist? '.installed'
      redirect '/setup'
    else
      if !session[:username] or User.first(:username => session[:username]).nil? then
        redirect '/login'
      end
    end
  end
end
