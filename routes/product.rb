class CallController < Sinatra::Application
 
  before /^(\/product)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/product' do
    @products = Product.all()
    redirect to '/products'
  end
  
  get '/product/add/' do
    erb :'product_add'
  end
  
  get '/product/edit/:id' do
    @product = Product.first(:id => params['id'])
    erb :'product_edit'
  end
  
  post '/product/add' do
    product = Product.first(:external_id => params['external_id'])
    
    if product.nil?
      product.create(:external_id => params['external_id'], :product_type => params['name'], )
    end
    productlist = '/products'
    redirect to productlist
  end
  
  post '/product/delete' do
    product = Product.first(:id => params['id'])
    
    if product.nil?
      product.destroy
    end
    productlist = '/products'
    redirect to productlist
  end
  
  post '/product/edit' do
    product = Product.first(:id => params['id'])
    
    if !product.nil?
      if params['external_id'].nil?
        product.external_id = params['external_id']
      end

      if params['name'].nil?
        product.name = params['name']
      end
      product.updated_at = Time.now
      product.save
      product.reload
    end
    productlist = '/products'
    redirect to productlist
  end
  
end
