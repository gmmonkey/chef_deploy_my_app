name "appserver"

description "I provide application services"
run_list(
   "recipe[rvm::ruby_192]",
   "recipe[my_app::setup]",
   "recipe[my_app::deploy]"
)
