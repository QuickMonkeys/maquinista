include_recipe "ruby_rbenv"


mysql_service 'default' do
  port '3306'
  bind_address '0.0.0.0'
  version '5.7'
  initial_root_password ''
  action [:create, :start]
end

rbenv_script "bundle_install" do
  rbenv_version ENV['RUBY_VERSION']
  user          "vagrant"
  group         "vagrant"
  cwd           "/maquinista/"
  code          %{rbenv rehash && bundle install}
end

rbenv_script "setup_database" do
  rbenv_version ENV['RUBY_VERSION']
  user          "vagrant"
  group         "vagrant"
  cwd           "/maquinista/"
  code          %{rbenv rehash && bundle exec rake db:setup}
end