Hello!
====

This is a current WIP project based on [Sinatra](http://www.sinatrarb.com/) and [Twitter Bootstrap](http://getbootstrap.com/).

This project is like a microCRM, is not complex as a full CRM, but it will allow you to upload a list of clients to allow your comercials to call their.

The Sales manager imports a list in csv format and this is stored in a MySQL(or whatevah db) and then the saleman/comercials clicks to view the number of an already client and ask him if he want't something.

TLDR: "So who should my salesman call now?"

Go!
===

Download and run sinatra-bootstrap:

    git clone https://github.com/JustDevZero/CallControler.git
    
    cd CallControl
    bundle install             # To install sinatra
    
    sh callcontroller.sh start    # To run the sample
	
Then open [http://localhost:3000/](http://localhost:3000/)

What's next?
============
- Finish the minimal function project, not yet functional
- Adapt the DataMapper part to work with MySQL
- Create an online ticket system, to allow the comercials to get help from IT team without messing with bugtrackers.
- Try the rerun gem to restart Sinatra automatically when you change source files: https://github.com/alexch/rerun
- Manage cron/scheduled jobs
