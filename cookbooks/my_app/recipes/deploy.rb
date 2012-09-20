deploy "/home/my_app/current" do
  repo "git@github.com:gmmonkey/my_app.git"
  revision "HEAD"
  user "my_app"
  enable_submodules false
  migrate false # Would set this to true, but without a postgres DB it will break.
  migration_command "rake db:migrate"
  environment "RAILS_ENV" => node.chef_environment
  shallow_clone true
  action :deploy # or :rollback
  restart_command "touch tmp/restart.txt"
  git_ssh_wrapper "wrap-ssh4git.sh"
  scm_provider Chef::Provider::Git
end