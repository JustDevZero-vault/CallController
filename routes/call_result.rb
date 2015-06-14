# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  before /^(\/callresult)/ do
    unless user.is_admin? || user.is_manager?
      redirect "/"
    end
  end
  
  get '/callresults' do
    @call_results = CallResult.all(:code.not => 'Undefined')
    erb :'call_result_overview'
  end
  
  post '/callresult/add' do
    ht = HTMLEntities.new
    un = User.first(:username => session['username'])
    callresult = CallResult.first_or_create(:code => params['new_call_result_code'], :description => ht.encode(params['new_call_result_description']), :user => un)
    redirect to '/callresults'
  end
  
  post '/callresult/edit' do
    ht = HTMLEntities.new
    callresult = CallResult.first(:id => params['edit_call_result_id'])
    if !callresult.nil?
      callresult.update(:code => ht.encode(params['edit_call_result_code'])) if !params['edit_call_result_code'].nil?
      callresult.update(:description => ht.encode(params['edit_call_result_description'])) if !params['edit_call_result_description'].nil?
      callresult.save
      callresult.reload
    end
    redirect to '/callresults'
    
  end
  
  post '/callresult/del' do
    callresult = CallResult.first(:id => params['delete_call_result_id'])
    default_result = CallResult.first(:code => 'Undefined')
    sales_with_result = Sale.all(:call_result => callresult)
    sales_with_result.update(:call_result => default_result)
    callresult.destroy
    redirect to '/callresults'
  end
  
end
