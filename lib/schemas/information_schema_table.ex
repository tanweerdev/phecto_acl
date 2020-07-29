defmodule ExAcl.InformationSchemaTable do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Query

  # schema "information_schema.tables" do
  @primary_key false
  schema "tables" do
    field(:table_catalog, :string)
    field(:table_schema, :string)
    field(:table_name, :string)
    field(:table_type, :string)

    field(:self_referencing_column_name, :string)
    field(:reference_generation, :string)
    field(:user_defined_type_catalog, :string)
    field(:user_defined_type_schema, :string)
    field(:user_defined_type_name, :string)
    field(:is_insertable_into, :string)
    field(:is_typed, :string)
    field(:commit_action, :string)
  end

  def get_all_tables(repo) do
    query =
      from(t in ExAcl.InformationSchemaTable,
        where: t.table_schema == "public" and t.table_type == "BASE TABLE"
      )

    repo.all(query, prefix: :information_schema)
  end
end
