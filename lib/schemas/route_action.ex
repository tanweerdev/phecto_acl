defmodule PhEctoAcl.RouteAction do
  defmacro __using__(options) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      @role_schema unquote(options)[:role_schema]
      if !@role_schema do
        raise "please define role_schema when using route action schema"
      end

      @role_route_action_schema unquote(options)[:role_route_action_schema]
      if !@role_route_action_schema do
        raise "please define role_route_action_schema when using route action schema"
      end

      schema "route_actions" do
        field(:level, :integer)
        field(:path, {:array, :string}, default: [])
        field(:http_method, :string)
        field(:name, :string)
        field(:description, :string)
        many_to_many(:roles, @role_schema, join_through: "roles_route_actions")
        has_many(:roles_route_actions, @role_route_action_schema)
      end

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [
          :level,
          :path,
          :http_method,
          :name,
          :description
        ])
        |> validate_inclusion(:http_method, ["POST", "GET", "PATCH", "PUT", "DELETE"],
          message: "Invalid Request Type"
        )
        |> unique_constraint(:path,
          name: :path_http_method_index,
          message: "Path and Http method already exist"
        )
        |> validate_required([:name, :http_method, :path])
      end

      defoverridable changeset: 2
    end
  end
end
