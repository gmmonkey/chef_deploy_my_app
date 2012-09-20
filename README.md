chef_deploy_my_app
==================

Chef configuration (cookbooks/roles etc.) required to deploy the my_app project

If you want to run this, you will need:

* RVM
* rvm install 1.9.2-p125
* gem install rake bundler
* bundle install

Then you can upload to a chefserver:

* configure .chef/production.rb to point to your chefserver
* bundle exec spiceweasel -c .chef/production.rb --extractlocal

Then you can bootstrap the box (assume the box is called app00) like this...

* knife bootstrap app00 --ssh-port 22 --template-file .chef/bootstrap/debian.erb -x chef --sudo app00 -c .chef/production.rb -r "$( cat nodes/app00.json | grep role | cut -d\" -f 2 | paste -sd, - )"

Or run 

$ chef-client
