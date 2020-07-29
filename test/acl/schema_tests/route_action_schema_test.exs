defmodule ExAcl.RouteActionTest do
  use ExUnit.Case
  alias ExAclTest.RouteAction

  test "changeset with valid attributes" do
    changeset =
      RouteAction.changeset(%RouteAction{}, %{
        level: 1,
        http_method: "POST",
        name: "admin",
        description: "test1",
        path: ["v1", "user", "path"]
      })

    assert changeset.valid?
  end

  test "changeset with inclusion attribute constraint" do
    changeset =
      RouteAction.changeset(%RouteAction{}, %{
        level: 1,
        http_method: "wrong",
        name: "admin",
        description: "test1",
        path: ["v1", "user", "path"]
      })

    assert changeset.errors == [
             http_method:
               {"Invalid Request Type",
                [validation: :inclusion, enum: ["POST", "GET", "PATCH", "PUT", "DELETE"]]}
           ]
  end

  test "changeset with empty params" do
    changeset = RouteAction.changeset(%RouteAction{}, %{})

    assert changeset.errors == [
             name: {"can't be blank", [validation: :required]},
             http_method: {"can't be blank", [validation: :required]}
           ]
  end
end
