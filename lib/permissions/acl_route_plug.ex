defmodule Acl.Plug.Authorize do
  defmacro __using__(optionz) do
    quote do
      # TODO: require options and raise errors if nil
      @options unquote(optionz)

      use Plug.Builder
      def init(options), do: options

      def call(conn, opts) do
        current_user = get_user(conn)

        conn_path = ExAcl.PermissionSystem.router_path(conn)

        actions =
          ExAcl.PermissionSystem.route_level_permissions(
            current_user.id,
            conn.method,
            conn_path,
            @options
          )

        if actions == true do
          conn
        else
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(403, Jason.encode!("Permission denied"))
          |> halt
        end
      end

      def get_user(conn) do
        nil
      end

      defoverridable call: 2, get_user: 1
    end
  end
end
