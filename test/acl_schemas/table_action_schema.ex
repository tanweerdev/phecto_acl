defmodule ExAclTest.TableAction do
  use ExAcl.TableAction,
    role_schema: ExAclTest.Role,
    role_table_action_schema: ExAclTest.RoleTableAction
end
