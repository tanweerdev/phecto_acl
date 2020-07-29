defmodule ExAclTest.RoleTableAction do
  use PhEctoAcl.RoleTableAction,
    role_schema: ExAclTest.Role,
    table_action_schema: ExAclTest.TableAction
end
