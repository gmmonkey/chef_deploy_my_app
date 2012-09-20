name "base"

description "All systems to get this role."
run_list(
   "recipe[users::setup_groups]",
   "recipe[users::setup]"
)
