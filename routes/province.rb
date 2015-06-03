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
    cn = Country.first(:id => params['country_id'])
    @countries = Contry.all()
    Province.create(:country => cn, :name => html_escape(params['province_name']))
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
      if params['country_id'].nil?
        cn = Country.first(:id => params['country_id'])
        province.update(:country => cn)
      end
      if params['name'].nil?
        province.update(:name => html_escape(param['name']))
      end
    end
    redirect to '/provinces'
  end
  
  
  post '/province/migrate' do
    province = Province.all()
    if province.nil?
      countries = Countries.all
      if !countries.nil?
        Thread.new do
          Province.begin_migrate
        end
      end
    end
    redirect to '/countries'
  end
    
end
