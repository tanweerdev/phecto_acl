defmodule ExAclTest.Role do
  use ExAcl.Role,
    user_role_schema: ExAclTest.UserRole,
    route_action_schema: ExAclTest.RouteAction,
    table_action_schema: ExAclTest.TableAction
end
