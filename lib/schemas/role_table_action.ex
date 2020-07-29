defmodule PhEctoAcl.RoleTableAction do
  defmacro __using__(options) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      @primary_key false

      @role_schema unquote(options)[:role_schema]
      if !@role_schema do
        raise "please define role_schema when using role table action schema"
      end

      @table_action_schema unquote(options)[:table_action_schema]
      if !@table_action_schema do
        raise "please define table_action_schema when using role table action schema"
      end

      schema "roles_table_actions" do
        belongs_to(:role, @role_schema, primary_key: true, type: :string)
        belongs_to(:table_action, @table_action_schema, primary_key: true)
      end

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:role_id, :table_action_id])
        |> validate_required([:role_id, :table_action_id])
        |> foreign_key_constraint(:role_id)
        |> foreign_key_constraint(:table_action_id)
        |> unique_constraint(:role_id,
          name: :roles_table_actions_pkey,
          message: "Table action passed in params has already been assigned to this role"
        )
      end

      defoverridable changeset: 2
    end
  end
end
