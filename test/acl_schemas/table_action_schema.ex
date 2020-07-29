defmodule PhEctoAclTest.TableAction do
  use PhEctoAcl.TableAction,
    role_schema: PhEctoAclTest.Role,
    role_table_action_schema: PhEctoAclTest.RoleTableAction
end
