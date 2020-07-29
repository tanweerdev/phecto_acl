defmodule PhEctoAcl.RoleTableActionTest do
  use ExUnit.Case
  alias ExAclTest.RoleTableAction

  test "changeset with valid attributes" do
    changeset =
      RoleTableAction.changeset(%RoleTableAction{}, %{role_id: "admin", table_action_id: 1})

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RoleTableAction.changeset(%RoleTableAction{}, %{role_id: -1, table_action_id: -1})

    assert changeset.errors == [role_id: {"is invalid", [type: :string, validation: :cast]}]
  end

  test "changeset with empty params" do
    changeset = RoleTableAction.changeset(%RoleTableAction{}, %{})

    assert changeset.errors == [
             role_id: {"can't be blank", [validation: :required]},
             table_action_id: {"can't be blank", [validation: :required]}
           ]
  end
end
