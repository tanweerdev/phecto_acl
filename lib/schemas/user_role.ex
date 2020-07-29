defmodule PhEctoAcl.UserRole do
  defmacro __using__(options) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      @primary_key false

      @user_schema unquote(options)[:user_schema]
      if !@user_schema do
        raise "please define user_schema when using user role schema"
      end

      @instance_schema unquote(options)[:instance_schema]

      if !@instance_schema do
        raise "please define instance_schema when using user role schema"
      end

      @role_schema unquote(options)[:role_schema]

      if !@role_schema do
        raise "please define role_schema when using user role schema"
      end

      schema "users_roles" do
        belongs_to(:user, @user_schema, primary_key: true)
        belongs_to(:instance, @instance_schema, primary_key: true)
        belongs_to(:role, @role_schema, primary_key: true, type: :string)
      end

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:user_id, :role_id, :instance_id])
        |> validate_required([:user_id, :role_id, :instance_id])
        |> foreign_key_constraint(:user_id)
        |> foreign_key_constraint(:instance_id)
        |> unique_constraint(:user_id,
          name: :users_roles_pkey,
          message: "Role passed in params has already been assigned to this user and instance"
        )
        |> foreign_key_constraint(:role_id)
      end

      defoverridable changeset: 2
    end
  end
end
