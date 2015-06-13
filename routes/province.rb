class CallController < Sinatra::Application
 
  before /^(\/province)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/provinces' do
    @provinces = Province.all()
    @countries = Country.all()
    erb :'provinces_overview'
  end
   
  post '/province/add' do
    cn = Country.first(:id => params['new_edit_country_id'])
    @countries = Country.all()
    Province.create(:country => cn, :name => html_escape(params['province_name']))
    
    if !cn.nil?
      if !params['new_province_name'].nil? &&  !params['new_province_code'].nil? &&  !params['new_province_postal_code'].nil? &&  !params['new_province_phone_prefix'].nil? && 
        province = Province.create(:country => cn, :name => html_escape(params['new_province_name']), :code => html_escape(params['new_province_code']), :postal_code => html_escape(params['new_province_postal_code']), :phone_code => html_escape(params['new_province_phone_prefix']))
      end
    end
    redirect to '/provinces'
  end
  
  post '/province/del' do
    province = Province.first(:id => params['id'])
    province.destroy
    redirect to '/provinces'
  end
  
  post '/province/edit' do
    province = Province.first(:id => params['province_id'])
    if !province.nil?
      if params['edit_country_id'].nil?
        cn = Country.first(:id => params['edit_country_id'])
        province.update(:country => cn)
      end
      
      province.update(:code => ht.encode(params['edit_province_code'], :named)) if !params['edit_province_code'].nil?
      province.update(:phone_code => ht.encode(params['edit_province_phone_prefix'], :named)) if !params['edit_province_phone_prefix'].nil?
      province.update(:name => ht.encode(params['edit_province_name'], :named)) if !params['edit_province_name'].nil?
    end
    redirect to '/provinces'
  end
  
  
  post '/province/migrate' do
    province = Province.all()
    if province.count < 1
      countries = Country.all()
      if countries.all.count > 1
        Thread.new do
          Province.begin_migrate('ES')
        end
      end
    end
    #~ redirect to '/provinces'
  end
    
end
