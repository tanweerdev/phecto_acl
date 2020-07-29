defmodule PhEctoAcl.TableActionTest do
  use ExUnit.Case
  alias ExAclTest.TableAction

  test "changeset with valid attributes" do
    changeset =
      TableAction.changeset(%TableAction{}, %{
        level: 1,
        table: "users",
        name: "admin",
        description: "test1",
        method: "CREATE"
      })

    assert changeset.valid?
  end

  test "changeset with inclusion attribute constraint" do
    changeset =
      TableAction.changeset(%TableAction{}, %{
        level: 1,
        table: "users",
        name: "admin",
        description: "test1",
        method: "wrong"
      })

    assert changeset.errors == [
             method:
               {"Invalid method Type",
                [
                  validation: :inclusion,
                  enum: ["READ", "CREATE", "UPDATE", "INDEX", "DELETE"]
                ]}
           ]
  end

  test "changeset with empty params" do
    changeset = TableAction.changeset(%TableAction{}, %{})

    assert changeset.errors == [
             name: {"can't be blank", [validation: :required]},
             method: {"can't be blank", [validation: :required]},
             table: {"can't be blank", [validation: :required]}
           ]
  end
end
