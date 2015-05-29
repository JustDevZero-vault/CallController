Hello!
====

This is a current WIP project based on [Sinatra](http://www.sinatrarb.com/) and [Twitter Bootstrap](http://getbootstrap.com/).

This project is like a microCRM, is not complex as a full CRM, but it will allow you to upload a list of clients to allow your comercials to call their.

Go!
===

Download and run sinatra-bootstrap:

    git clone protocol://url/repository.git
    
    cd sinatra-bootstrap
    bundle install             # To install sinatra
    
    bundle exec ruby app.rb    # To run the sample
	
Then open [http://localhost:4567/](http://localhost:4567/)

What's next?
============
- Finish the minimal function project, not yet functional
- Adapt the DataMapper part to work with MySQL
- Create an online ticket system, to allow the comercials to get help from IT team without messing with bugtrackers.
- Try the rerun gem to restart Sinatra automatically when you change source files: https://github.com/alexch/rerun
- Manage cron/scheduled jobs
