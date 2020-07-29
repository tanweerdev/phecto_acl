defmodule PhEctoAclTest.Role do
  use PhEctoAcl.Role,
    user_role_schema: PhEctoAclTest.UserRole,
    route_action_schema: PhEctoAclTest.RouteAction,
    table_action_schema: PhEctoAclTest.TableAction
end
