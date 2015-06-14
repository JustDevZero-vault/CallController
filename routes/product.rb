class CallController < Sinatra::Application
 
  before /^(\/product)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/products' do
    @products = Product.all()
    redirect to '/products'
  end
  
  #~ get '/product/add/' do
    #~ erb :'product_add'
  #~ end
  
  #~ get '/product/edit/:id' do
    #~ @product = Product.first(:id => params['id'])
    #~ erb :'product_edit'
  #~ end
  
  post '/product/add' do
    ht = HTMLEntities.new
    product = Product.first_or_create(:external_id => params['external_id'], :product_type => ht.encode(params['name'], :named))
    redirect to '/products'
  end
  
  post '/product/delete' do
    product = Product.first(:id => params['id'])
    product.destroy if !product.nil?
    redirect to '/products'
  end
  
  post '/product/edit' do
    product = Product.first(:id => params['id'])
    
    if !product.nil?
      ht = HTMLEntities.new
      product.update(:name => ht.encode(params['edit_name'], :named)) if !params['edit_name'].nil?
      product.update(:external_id => params['edit_external_id']) if !params['edit_external_id'].nil?
      product.save
      product.reload
    end
    redirect to '/products'
  end
  
end
