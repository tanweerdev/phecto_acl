defmodule ExAclTest.TableAction do
  use PhEctoAcl.TableAction,
    role_schema: ExAclTest.Role,
    role_table_action_schema: ExAclTest.RoleTableAction
end
