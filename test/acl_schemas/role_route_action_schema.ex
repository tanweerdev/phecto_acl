defmodule ExAclTest.RoleRouteAction do
  use PhEctoAcl.RoleRouteAction,
    role_schema: ExAclTest.Role,
    route_action_schema: ExAclTest.RouteAction
end
