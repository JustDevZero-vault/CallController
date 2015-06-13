class CallController < Sinatra::Application
  get '/setup' do
    status 200
    home = '/'
    if File.exist? '.installed'
      redirect to home
    else
      erb :'system/setup', :layout => false
    end
  end

  post '/setup' do
    status 200
    home = '/'
    if File.exist? '.installed'
      redirect to home
    else
      if params['password'].empty? || params['username'].empty? || params['email'].empty?
        notification = Notification.create(:type => :error, :sticky => false, :message => 'All fields required')
        halt erb(:'system/setup')
      end
      Setup.new()
      Country.begin()
      Province.begin_migrate('ES')
      #~ un = User.new(params['username'], params['email'], params['password'], params['first_name'], 'last_name')
      un = User.first_or_create(:username => params['username'], :email => params['email'], :password => BCrypt::Password.create(params['password']), :first_name => params['first_name'], :last_name => params['last_name'], :active => true)
      admins = Role.new(:name => "admins", :capabilities => 'admin')
      admins.add_member(un)
      CallResult.first_or_create(:code => 'Undefined', :code => 'Undefined', :user => un)
      Role.create(:name => 'agents', :capabilities => 'agent')
      Role.create(:name => 'coachers', :capabilities => 'coacher')
      Role.create(:name => 'supervisors', :capabilities => 'supervisor')
      Role.create(:name => 'managers', :capabilities => 'manager')
    end
    redirect to home
  end

  begin
    get '/install/exchange' do
      Setup.one_click_install_exchange if !Gem::Specification::find_all_by_name('viewpoint').any?
      erb 'Reloading, please wait... <script> setTimeout(function () { window.location.href = "/settings"; }, 5000); </script>'
    end
  end
end
