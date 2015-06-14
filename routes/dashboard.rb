# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  get '/' do
    if user.is_admin? || user.is_manager?
      erb :admin_dashboard
    else
      erb :dashboard
    end
  end
end
