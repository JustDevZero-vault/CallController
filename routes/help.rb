# -*- coding: utf-8 -*-
class CallController < Sinatra::Application
  get '/help' do
    loc = I18n.locale.to_s
    @doc = 'doc/'+loc+'/README.md'
    if !File.exist?("public/"+@doc)
      @doc = 'doc/en/README.md'
    end
    if File.exist?("public/"+@doc)
      erb :help
    else
      not_found
    end
  end

  get '/help/:doc' do
    loc = I18n.locale.to_s
    @doc = 'doc/'+loc+'/'+params[:doc]
    if !File.exist?("public/"+@doc)
      @doc = 'doc/en/'+params[:doc]
    end
    if File.exist?("public/"+@doc)
      erb :help
    else
      not_found
    end
  end
end
