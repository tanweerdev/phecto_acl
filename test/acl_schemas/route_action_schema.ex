defmodule ExAclTest.RouteAction do
  use ExAcl.RouteAction,
    role_schema: ExAclTest.Role,
    role_route_action_schema: ExAclTest.RoleRouteAction
end
