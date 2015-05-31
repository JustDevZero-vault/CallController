Installing CallController
===============
<br/>

**1. Install dependencies**

Most dependencies are installed via gems, but it first needs ruby, git, make and some standard
libraries for it to work

On Debian-based systems (as root):

    apt-get update && apt-get install -y ruby-full ruby-dev git libxslt-dev libxml2-dev libsqlite3-dev make libssl-dev libmysqlclient-dev

On RedHat-based systems:

    yum install -y ruby ruby-devel git libxslt-devel libxml2-devel libsqlite3-devel make mysql-devel openssl-devel

**2. Install CallController from git**

Install bundler and clone the git repository

    gem install bundler
    git clone https://github.com/JustDevZero/CallControler.git

Or get the development branch (recommended while it is in heavy development stage,
might be unestable though)

    git clone https://github.com/JustDevZero/CallControler.git -b devel

Install CallController and all the dependencies

    cd CallController
    bundle install

**3. Start CallController**

    ./callcontroller.sh start

Access your newly CallController installation from the machine itself, or using the IP and
the port 3000
([http://localhost:3000/](http://localhost:3000/))

**4. Setup**

Once you open CallController for the first time, it will prompt you for an user, email, password.

When all data has been provided, CallController will set up the new installation allowing you to use it.