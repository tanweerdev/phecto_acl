defmodule PhEctoAcl.Migrations.CreateRoleActions do
  use Ecto.Migration

  def change do
    create table(:roles_route_actions, primary_key: false) do
      add(:route_action_id, references(:route_actions), null: false, primary_key: true)

      add(:role_id, references(:roles, column: :id, type: :string), null: false, primary_key: true)
    end
  end
end
