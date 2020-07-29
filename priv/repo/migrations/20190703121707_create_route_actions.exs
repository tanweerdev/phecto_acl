defmodule PhEctoAcl.Migrations.CreateRouteActions do
  use Ecto.Migration

  def change do
    create table(:route_actions) do
      add(:level, :integer, null: false)
      add(:path, {:array, :string}, null: false, default: [])
      add(:http_method, :string, null: false)
      add(:name, :string, null: false)
      add(:description, :string)
    end

    create(unique_index(:route_actions, [:path, :http_method], name: :path_http_method_index))
  end
end
