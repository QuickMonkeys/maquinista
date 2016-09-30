# vagrant-frontback
Vagrant setup for an API back end Rails server. 

##Prerequisities: 
Install latest versions of Vagrant, VirtualBox, ChefDK (https://downloads.chef.io/chef-dk/)

Then clone this project to your local environment:

`git clone https://github.com/OndrejKu/vagrant-frontback`

Then cd to this directory

`cd vagrant-frontback`

Next thing is to have the Ruby on Rails project on your local. If that is true edit the Vagrantfile. Right on the top you should see 
constant BACKEND_PATH - change it to relative or absolute path.

And then last thing is to run command:

`vagrant up`

This command should install and run the whole environment on Ubuntu 14.04 server. It's going to take while (easily 1 hour).
You don't have to do nothing after it's installed. 

To verify that the server is running just type in to your console this command: 

`curl -x http://localhost:3000/api/links/ping.json` 

If it spits a lot of lines of code you're all set.
