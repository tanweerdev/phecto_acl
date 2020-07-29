defmodule ExAcl.Role do
  defmacro __using__(options) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      # @derive Jason.Encoder
      @primary_key {:id, :string, autogenerate: false}

      @user_role_schema unquote(options)[:user_role_schema]
      if !@user_role_schema do
        raise "please define user_role_schema when using role schema"
      end

      @table_action_schema unquote(options)[:table_action_schema]

      if !@table_action_schema do
        raise "please define table_action_schema when using role schema"
      end

      @route_action_schema unquote(options)[:route_action_schema]

      if !@route_action_schema do
        raise "please define route_action_schema when using role schema"
      end

      schema "roles" do
        field(:is_active, :boolean, default: true)
        field(:description, :string)
        # TODO: Define bool super_admin_routes field, if set no need to validate any routes
        # TODO: Define bool super_admin_tables field, if set no need to validate any table action
        field(:constraints, :map, default: %{})
        many_to_many(:table_actions, @table_action_schema, join_through: "roles_table_actions")
        many_to_many(:route_actions, @route_action_schema, join_through: "roles_route_actions")
        many_to_many(:user_roles, @user_role_schema, join_through: "users_roles")
      end

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [
          :id,
          :is_active,
          :description,
          :constraints
        ])
        |> unique_constraint(:id, name: :roles_pkey)
        |> validate_required([:id])
        |> validate_format(:id, ~r/^([a-z0-9A-Z(-_ )])+$/i, message: "only alphanumaric allowed")
      end

      defoverridable changeset: 2
    end
  end
end
