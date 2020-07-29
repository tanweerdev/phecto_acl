defmodule ExAclTest.UserRole do
  use ExAcl.UserRole,
    user_schema: ExAclTest.User,
    instance_schema: ExAclTest.Instance,
    role_schema: ExAclTest.Role
end
