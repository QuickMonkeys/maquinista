include_recipe "ruby_rbenv"

rv = node['maquinista']['ruby_version']

execute "addlocale" do 
  command "locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8"
  action :run 
end

rbenv_script "bundle_install" do
  rbenv_version rv
  user          "vagrant"
  group         "vagrant"
  cwd           "/maquinista/"
  code          %{rbenv rehash && bundle install}
end

rbenv_script "setup_database" do
  rbenv_version rv
  user          "vagrant"
  group         "vagrant"
  cwd           "/maquinista/"
  code          %{rbenv rehash && bundle exec rake db:setup}
end