# Maquinista
This is Vagrant workflow for you Ruby on Rails development

##Prerequisities: 
Install latest versions of Vagrant, VirtualBox, ChefDK (https://downloads.chef.io/chef-dk/)

##Installation: 

Create your project folder:

`mkdir example.com`

Then clone this project into example.com folder:

`cd example.com`

`https://github.com/QuickMonkeys/maquinista`

Create second folder called site in the same directory:

`mkdir site`

Clone your repository inside your site folder:

`cd site && git clone https://github.com/yourrailsproject`

Then cd to maquinista

`cd maquinista`

Here open your config.yml with your prefered text editor and change change ruby_version accordingly to version in your Gemfile.

###Database setup for MySQL:
In your config/database.yml change user to root and leave password empty. Also change (or add) socket: /var/run/mysql-default/mysqld.sock

###Database setup for PostgreSQL
In config/database.yml change user to postgres and password to maquinista.

And then last thing is to run command:

`vagrant up`

This command should install and run the whole environment on Ubuntu 16.04 server. It's going to take while (easily 1 hour).


Maquinista will install all your environment and setup the database. Then you simply login to your new virtual machine with command: 

`vagrant ssh`

Enter to your project directory under /maquinista/ and run this command:

`bundle exec rails s -b 0.0.0.0`

From your host computer you can access URL in your browser

`http://localhost:3000` 

and you should see the welcome screen of your Rails app.

Everytime you generate something on your new Vagrant server and you want it back, simply type `vagrant rsync-back` and if you change some file in your repo and want to send it to your server type `vagrant rsync`.