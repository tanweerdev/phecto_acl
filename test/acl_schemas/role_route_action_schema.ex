defmodule PhEctoAclTest.RoleRouteAction do
  use PhEctoAcl.RoleRouteAction,
    role_schema: PhEctoAclTest.Role,
    route_action_schema: PhEctoAclTest.RouteAction
end
