defmodule PhEctoAcl.RoleRouteActionTest do
  use ExUnit.Case
  alias PhEctoAclTest.{RoleRouteAction}

  test "changeset with valid attributes" do
    changeset =
      RoleRouteAction.changeset(%RoleRouteAction{}, %{role_id: "admin", route_action_id: 1})

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RoleRouteAction.changeset(%RoleRouteAction{}, %{role_id: -1, route_action_id: -1})

    assert changeset.errors == [role_id: {"is invalid", [type: :string, validation: :cast]}]
  end

  test "changeset with empty params" do
    changeset = RoleRouteAction.changeset(%RoleRouteAction{}, %{})

    assert changeset.errors == [
             role_id: {"can't be blank", [validation: :required]},
             route_action_id: {"can't be blank", [validation: :required]}
           ]
  end
end
