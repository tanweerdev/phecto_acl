defmodule PhEctoAclTest.UserRole do
  use PhEctoAcl.UserRole,
    user_schema: PhEctoAclTest.User,
    instance_schema: PhEctoAclTest.Instance,
    role_schema: PhEctoAclTest.Role
end
