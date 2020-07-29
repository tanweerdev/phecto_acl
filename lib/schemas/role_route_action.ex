defmodule PhEctoAcl.RoleRouteAction do
  defmacro __using__(options) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      @primary_key false
      @role_schema unquote(options)[:role_schema]
      if !@role_schema do
        raise "please define role_schema when using role route action schema"
      end

      @route_action_schema unquote(options)[:route_action_schema]
      if !@route_action_schema do
        raise "please define route_action_schema when using role route action schema"
      end

      schema "roles_route_actions" do
        belongs_to(:role, @role_schema, primary_key: true, type: :string)
        belongs_to(:route_action, @route_action_schema, primary_key: true)
      end

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:role_id, :route_action_id])
        |> validate_required([:role_id, :route_action_id])
        |> foreign_key_constraint(:role_id)
        |> foreign_key_constraint(:route_action_id)
        |> unique_constraint(:role_id,
          name: :roles_route_actions_pkey,
          message: "Route action passed in params has already been assigned to this role"
        )
      end

      defoverridable changeset: 2
    end
  end
end
