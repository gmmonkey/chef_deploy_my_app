# Cookbook Name:: users
# Recipe:: fromroles

node['roles'].each do |role|
  search(:users, 'roles:' + role) do |user_data|

    home_dir = "/home/#{user_data['id']}"

    # fixes CHEF-1699
    ruby_block "reset group list" do
      block do
        Etc.endgrent
      end
      action :nothing
    end

    user user_data['id'] do
      uid user_data['uid']
      gid user_data['gid']
      shell user_data['shell']
      comment user_data['comment']
      supports :manage_home => true
      home home_dir
      notifies :create, "ruby_block[reset group list]", :immediately
    end

    directory "#{home_dir}" do
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0700"
    end

    directory "#{home_dir}/.ssh" do
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0700"
    end

    template "#{home_dir}/.ssh/authorized_keys" do
      source "authorized_keys.erb"
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0600"
      variables :ssh_keys => user_data['ssh_keys']
    end
 
    cookbook_file "#{home_dir}/.ssh/known_hosts" do
      source "known_hosts"
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0600"
    end
 
    cookbook_file "#{home_dir}/.bash_profile" do
      source "bash_profile"
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0600"
    end

    cookbook_file "#{home_dir}/.bashrc" do
      source "bashrc"
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0600"
    end

    directory "#{home_dir}/.bash_profile.d" do
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0700"
    end

    directory "#{home_dir}/.bashrc.d" do
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0700"
    end

    cookbook_file "#{home_dir}/.bash_profile.d/shell_defaults" do
      source "bash_profile_shell_defaults"
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      mode "0600"
    end
    
    file "/#{home_dir}/.bashrc.d/chef_environment" do
      mode "0600"
      owner user_data['id']
      group user_data['gid'] || user_data['id']
      content <<-eos
        export CHEF_ENVIRONMENT=#{node.chef_environment}
      eos
    end
      
  end

end
