# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
 
  before /^(\/product)/ do
    unless user.is_admin?
      redirect "/"
    end
  end
  
  get '/products' do
    @products = Product.all()
    erb :products_overview
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
    product = Product.first_or_create(:external_id => ht.encode(params['new_product_external_id']), :name => ht.encode(params['new_product_name'], :named))
    redirect to '/products'
  end
  
  post '/product/del' do
    product = Product.first(:id => params['del_product_id'])
    product.destroy if !product.nil?
    redirect to '/products'
  end
  
  post '/product/edit' do
    product = Product.first(:id => params['edit_product_id'])
    
    if !product.nil?
      ht = HTMLEntities.new
      product.update(:name => ht.encode(params['edit_product_name'], :named)) if !params['edit_product_name'].nil? && !params['edit_product_name'].empty?
      product.update(:external_id => ht.encode(params['edit_product_external_id'])) if !params['edit_product_external_id'].nil? && !params['edit_product_external_id'].empty?
      product.save
      product.reload
    end
    redirect to '/products'
  end
  
end
