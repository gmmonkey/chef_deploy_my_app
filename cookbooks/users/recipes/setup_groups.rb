# Cookbook Name:: users
# Recipe:: groups

node['roles'].each do |role|
  search(:groups, 'roles:'+role) do |g|

    group g['id'] do
      group_name g['id']
      gid g['gid']
      action :create
    end
  
  end
end
