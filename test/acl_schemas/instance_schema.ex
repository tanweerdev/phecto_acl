defmodule ExAclTest.Instance do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:name]
  schema "" do
    field(:name, :string, virtual: true)
  end

  def changeset(data) when is_map(data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> apply_changes()
  end
end
