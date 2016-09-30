# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

Vagrant.require_version '>= 1.8.5'

MAQUINISTA_PATH = __dir__

config_file = File.join(MAQUINISTA_PATH, 'config.yml')

def fail_with_message(msg)
  fail Vagrant::Errors::VagrantError.new, msg
end

if File.exists?(config_file)
  site = YAML.load_file(config_file)['site']
  fail_with_message "No config found in #{config_file}." if site.to_h.empty?
else
  fail_with_message "#{config_file} was not found."
end

def require_plugins(plugins = {})
  needs_restart = false
  plugins.each do |plugin, version|
    next if Vagrant.has_plugin?(plugin)
    cmd =
      [
        'vagrant plugin install',
        plugin
      ]
    cmd << "--plugin-version #{version}" if version
    system(cmd.join(' ')) || exit!
    needs_restart = true
  end
  exit system('vagrant', *ARGV) if needs_restart
end

require_plugins \
  'vagrant-bindfs' => '0.4.8', 
  'vagrant-berkshelf' => '4.1.0',
  'vagrant-vbguest' => '0.12.0' ,
  'vagrant-rsync-back' => '0.0.1',
  'vagrant-hostmanager' => '1.8.5'

better_path = File.expand_path(site['local_path'], MAQUINISTA_PATH) 
first_site = Dir.glob(File.join(better_path, "*", "")).first
ruby_version = site['ruby_version']
ENV['RUBY_VERSION'] = ruby_version

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.ssh.forward_agent = true

  # Fix for: "stdin: is not a tty"
  # https://github.com/mitchellh/vagrant/issues/1673#issuecomment-28288042
  config.ssh.shell = %{bash -c 'BASH_ENV=/etc/profile exec bash'}

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000 

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.synced_folder first_site, "/maquinista/",
    # Tell Vagrant to use rsync for this shared folder.
    type: "rsync",
    rsync__auto: "true",
    rsync__exclude: ".git/",
    owner: "vagrant",
    group: "vagrant",
    id: "shared-folder-id"

  config.berkshelf.enabled = true

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "devops_library"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "vim"
    chef.add_recipe "libmysqlclient"
    chef.add_recipe "maquinista"

    # Install Ruby version and Bundler
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.3.0"],
          global: "2.3.0" ,
          gems: {
            "2.3.0"  => [
              { name: "bundler" }, 
              { name: "rake" }
            ]
          }
        }]
      }
    }
  end
end

def post_up_message
  msg = 'Your Maquinista Vagrant box is ready to use!'
  msg << "\n* Edit your config/database.yml file with socket: /var/run/mysql-default/mysqld.sock"
  msg << "\n* MySQL username is root and password is empty."
  msg << "\n* You can SSH into the machine with `vagrant ssh`."
  msg << "\n* Your Rails project is in `/maquinista/`."

  msg
end