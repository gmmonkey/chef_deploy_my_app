# Ordinarily I'd use something like this in conjunction with Spiceweasel 
# to be able to sync my github repo to a chef-server

current_dir =            File.dirname(__FILE__)
user =                   ENV['CHEFUSER'] || ENV['USER']
log_level                :info
log_location             STDOUT
node_name                user
client_key               "#{ENV['HOME']}/.chef/production/#{user}.pem"
validation_client_name   "chef-validator"
validation_key           "#{ENV['HOME']}/.chef/production/validation.pem"
chef_server_url          "http://some-chef-server:4000"
cache_type               "BasicFile"
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path		         ["#{current_dir}/../cookbooks"]
environment              "production"
