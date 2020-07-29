defmodule PhEctoAcl.TableAction do
  defmacro __using__(options) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      @role_schema unquote(options)[:role_schema]
      if !@role_schema do
        raise "please define role_schema when using table action schema"
      end

      @role_table_action_schema unquote(options)[:role_table_action_schema]
      if !@role_table_action_schema do
        raise "please define role_table_action_schema when using table action schema"
      end

      schema "table_actions" do
        field(:level, :integer)
        field(:table, :string)
        field(:method, :string)
        field(:name, :string)
        field(:description, :string)
        many_to_many(:roles, @role_schema, join_through: "roles_table_actions")
        has_many(:roles_table_actions, @role_table_action_schema)
      end

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [
          :level,
          :table,
          :method,
          :name,
          :description
        ])
        |> validate_inclusion(:method, ["READ", "CREATE", "UPDATE", "INDEX", "DELETE"],
          message: "Invalid method Type"
        )
        |> unique_constraint(:path,
          name: :table_method_index,
          message: "Table and Method already exist"
        )
        |> validate_required([:name, :method, :table])
      end

      defoverridable changeset: 2
    end
  end
end
