# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  get '/' do
    if user.is_admin? || user.is_manager? || user.is_coacher? || user.is_supervisor?
      @sales_today = Sale.all(:call_date => Date.today)
      erb :admin_dashboard
    else
      queue = User.first(:username => queue)
      @my_sales = Sale.all(:user => user, :call_date => Date.today)
      erb :dashboard
    end
  end
end
