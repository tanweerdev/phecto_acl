defmodule ExAclTest.RoleTableAction do
  use ExAcl.RoleTableAction,
    role_schema: ExAclTest.Role,
    table_action_schema: ExAclTest.TableAction
end
