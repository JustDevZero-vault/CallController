# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  get '/' do
    if user.is_admin? || user.is_manager? || user.is_coacher? || user.is_supervisor?
      @sales_today = Sale.all(:call_date => Date.today)
      erb :admin_dashboard
    else
      queue = User.first(:username => queue)
      time = Time.new
      my_sales1 = Sale.all(:user => user )
      my_sales = Sale.all(:updated_at => (DateTime.now.beginning_of_day..DateTime.now) )
      my_sales2 = Sale.all(:call_date => (DateTime.now.beginning_of_day..DateTime.now) )
      @my_sales = my_sales1 & my_sales2 + my_sales
      erb :dashboard
    end
  end
end
