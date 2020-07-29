defmodule PhEctoAcl.RoleTest do
  use ExUnit.Case
  alias ExAclTest.Role

  test "changeset with valid attributes" do
    changeset = Role.changeset(%Role{}, %{id: "admin"})

    assert changeset.valid?
  end

  test "changeset with invalid id" do
    changeset = Role.changeset(%Role{}, %{id: -1})

    assert changeset.errors == [id: {"is invalid", [type: :string, validation: :cast]}]
  end

  test "changeset with empty params" do
    changeset = Role.changeset(%Role{}, %{})

    assert changeset.errors == [id: {"can't be blank", [validation: :required]}]
  end
end
