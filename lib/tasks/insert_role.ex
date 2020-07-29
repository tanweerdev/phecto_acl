defmodule Mix.Tasks.InsertRole do
  use Mix.Task
  import Mix.Ecto
  import Ecto.Query
  alias PhEctoAcl.Role

  @shortdoc "mix insert_role"

  def run(args) do
    repo = parse_repo(args) |> List.first()

    [:postgrex, :ecto, :ecto_sql]
    |> Enum.each(&Application.ensure_all_started/1)

    repo.start_link()
    user = HaiData.Repo.one(from(user in HaiData.User, limit: 1))

    insert_role(user, repo)
  end

  def insert_role(user, repo) do
    route_actions = repo.all(PhEctoAcl.RouteAction)
    table_actions = repo.all(PhEctoAcl.TableAction)

    data = [
      %{
        id: "manager",
        description: "First Manager"
      }
    ]

    {_count, roles} = insert_all_roles(repo, data)

    user &&
      Enum.each(roles, fn role ->
        Enum.each(Enum.take(route_actions, 10), fn route ->
          data = [
            %{
              route_action_id: route.id,
              role_id: role.id
            }
          ]

          repo.insert_all(PhEctoAcl.RoleRouteAction, data,
            on_conflict: :replace_all,
            conflict_target: [:role_id, :route_action_id]
          )
        end)

        Enum.each(Enum.take(table_actions, 10), fn table_action ->
          data = [
            %{
              table_action_id: table_action.id,
              role_id: role.id
            }
          ]

          repo.insert_all(PhEctoAcl.RoleTableAction, data,
            on_conflict: :replace_all,
            conflict_target: [:role_id, :table_action_id]
          )
        end)
      end)
  end

  defp insert_all_roles(repo, data) do
    repo.insert_all(Role, data,
      on_conflict: :replace_all_except_primary_key,
      returning: true,
      conflict_target: [:id]
    )
  end
end
