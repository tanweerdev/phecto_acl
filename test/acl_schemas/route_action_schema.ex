defmodule PhEctoAclTest.RouteAction do
  use PhEctoAcl.RouteAction,
    role_schema: PhEctoAclTest.Role,
    role_route_action_schema: PhEctoAclTest.RoleRouteAction
end
