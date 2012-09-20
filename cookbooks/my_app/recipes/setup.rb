# Cookbook Name:: my_app
# Recipe:: setup
#
# Copyright message
# etc.
service_name = 'my_app'

database_servers = []
search(:node, "role:database_server").each do |dbserver|
  database_servers.push(dbserver.automatic_attrs["fqdn"])
end
primary_database_server = db_servers.first
security = data_bag_item('security', "#{node.chef_environment}_private")

# postgres

file "/home/#{service_name}/.bashrc.d/postgres_details" do
  mode "0600"
  owner "#{service_name}"
  group "#{service_name}_grp"
  content <<-eos
    export POSTGRES_HOST=#{primary_database_server}
    export POSTGRES_PORT=5432
    export POSTGRES_USER=#{service_name}
    export POSTGRES_PASSWORD=#{security['postgresql_passwords'][service_name]}
  eos
end

# rails

file "/home/#{service_name}/.bashrc.d/rails" do
  mode "0600"
  owner "#{service_name}"
  group "#{service_name}_grp"
  content <<-eos
    export RAILS_ENV=#{node.chef_environment}
  eos
end

# rack (not necessary, but I like to have it)

file "/home/#{service_name}/.bashrc.d/rack" do
  mode "0600"
  owner "#{service_name}"
  group "#{service_name}_grp"
  content <<-eos
    export RACK_ENV=#{node.chef_environment}
  eos
end

directory "/home/#{service_name}/current" do
  mode "0755"
  owner "#{service_name}"
  group "#{service_name}_grp"
end


