# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
 
  before /^(\/holiday)/ do
    unless user.is_admin? || user.is_manager?
      redirect "/"
    end
  end
  
  get '/holidays' do
    @holidays = Holiday.all()
    @provinces = Province.all()
    erb :holiday_overview
  end
   
  post '/holiday/add' do
    ht = HTMLEntities.new
    province = Province.first(:id => params['new_holiday_province_id'])
    holiday = Holiday.first_or_create(:date => params['new_holiday_date'].to_date, :province => province, :description => ht.encode(params['new_holiday_description'], :named) )
    redirect to '/holidays'
  end
  
  post '/holiday/del' do
    holiday = Holiday.first(:id => params['del_holiday_id'])
    holiday.destroy if !holiday.nil?
    redirect to '/holidays'
  end
  
  post '/holiday/edit' do
    holiday = Holiday.first(:id => params['edit_holiday_id'])
    province = Province.first(:id => params['edit_holiday_province_id'])
    if !holiday.nil?
      ht = HTMLEntities.new
      holiday.update(:description => ht.encode(params['edit_holiday_description'], :named)) if !params['edit_holiday_description'].nil? && !params['edit_holiday_description'].empty?
      holiday.update(:date => params['edit_holiday_date'].to_date) if !params['edit_holiday_date'].nil? && !params['edit_holiday_description'].empty?
      holiday.update(:province => province) if !province.nil?
      holiday.save
      holiday.reload
    end
    redirect to '/holidays'
  end
  
end
