defmodule Mix.Tasks.InsertTableActions do
  use Mix.Task
  import Mix.Ecto
  alias PhEctoAcl.InformationSchemaTable, as: Information
  alias PhEctoAcl.TableAction

  @shortdoc "mix insert_table_actions"

  def run(args) do
    repo = parse_repo(args) |> List.first()

    [:postgrex, :ecto, :ecto_sql]
    |> Enum.each(&Application.ensure_all_started/1)

    repo.start_link()

    Information.get_all_tables(repo)
    |> Enum.reject(fn table -> table.table_name == "schema_migrations" end)
    |> Enum.each(fn table ->
      data = [
        %{
          level: 2,
          table: table.table_name,
          method: "INDEX",
          name: "fetch #{table.table_name} records",
          description: ""
        },
        %{
          level: 1,
          table: table.table_name,
          method: "READ",
          name: "fetch #{table.table_name} records",
          description: ""
        },
        %{
          level: 2,
          table: table.table_name,
          method: "CREATE",
          name: "create #{table.table_name} record",
          description: ""
        },
        %{
          level: 2,
          table: table.table_name,
          method: "UPDATE",
          name: "update #{table.table_name} record ",
          description: ""
        },
        %{
          level: 3,
          table: table.table_name,
          method: "DELETE",
          name: "delete #{table.table_name} record",
          description: ""
        }
      ]

      insert_all(repo, data)
    end)
  end

  def insert_all(repo, data) do
    repo.insert_all(TableAction, data,
      on_conflict: :replace_all_except_primary_key,
      conflict_target: [:table, :method]
    )
  end
end
