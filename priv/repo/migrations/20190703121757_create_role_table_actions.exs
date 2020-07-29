defmodule ExAcl.Migrations.AddConstraintsFieldToUsers do
  use Ecto.Migration

  def change do
    create table(:roles_table_actions, primary_key: false) do
      add(:table_action_id, references(:table_actions), null: false, primary_key: true)

      add(:role_id, references(:roles, column: :id, type: :string), null: false, primary_key: true)
    end
  end
end
