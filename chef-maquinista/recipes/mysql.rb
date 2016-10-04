mysql_service 'default' do
  port '3306'
  bind_address '0.0.0.0'
  version '5.7'
  initial_root_password ''
  action [:create, :start]
end