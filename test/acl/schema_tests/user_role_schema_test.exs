defmodule PhEctoAcl.UserRoleTest do
  use ExUnit.Case
  alias ExAclTest.UserRole

  test "changeset with valid attributes" do
    changeset = UserRole.changeset(%UserRole{}, %{role_id: "admin", user_id: 1, instance_id: 1})

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserRole.changeset(%UserRole{}, %{role_id: -1, user_id: -1, instance_id: -1})

    assert changeset.errors == [role_id: {"is invalid", [type: :string, validation: :cast]}]
  end

  test "changeset with empty params" do
    changeset = UserRole.changeset(%UserRole{}, %{})

    assert changeset.errors == [
             user_id: {"can't be blank", [validation: :required]},
             role_id: {"can't be blank", [validation: :required]},
             instance_id: {"can't be blank", [validation: :required]}
           ]
  end
end
