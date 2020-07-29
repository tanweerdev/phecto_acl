defmodule Mix.Tasks.InsertRouteActions do
  use Mix.Task
  import Mix.Ecto
  alias PhEctoAcl.RouteAction

  @shortdoc "mix insert_route_actions"

  def run(args) do
    repo = parse_repo(args) |> List.first()

    [:postgrex, :ecto, :ecto_sql]
    |> Enum.each(&Application.ensure_all_started/1)

    repo.start_link()

    routes =
      PhEctoAcl.Routes.get_routes([HaiApi.Router])
      |> PhEctoAcl.Routes.filter_method_and_path_array()

    Enum.each(routes, fn {method, path} ->
      path_str = Enum.join(path, "/")

      data = [
        %{
          http_method: method,
          level: 1,
          path: path,
          name: "#{method} /#{path_str}",
          description: ""
        }
      ]

      insert_all(repo, data)
    end)
  end

  def insert_all(repo, data) do
    repo.insert_all(RouteAction, data,
      on_conflict: :replace_all_except_primary_key,
      conflict_target: [:path, :http_method]
    )
  end
end
