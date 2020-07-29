defmodule PhEctoAclTest.User do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:first_name, :last_name, :domain, :email_address, :username]
  schema "" do
    field(:first_name, :string, virtual: true)
    field(:last_name, :string, virtual: true)
    field(:domain, :string, virtual: true)
    field(:email_address, :string, virtual: true)
    field(:username, :string, virtual: true)
    many_to_many(:roles, PhEctoAclTest.Role, join_through: "users_roles")
  end

  def changeset(data) when is_map(data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> apply_changes()
  end
end
