defmodule PhEctoAclTest.RoleTableAction do
  use PhEctoAcl.RoleTableAction,
    role_schema: PhEctoAclTest.Role,
    table_action_schema: PhEctoAclTest.TableAction
end
