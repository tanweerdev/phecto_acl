defmodule PhEctoAcl.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:table_actions) do
      add(:level, :integer, null: false)
      add(:table, :string, null: false)
      add(:method, :string, null: false)
      add(:name, :string, null: false)
      add(:description, :string)
    end

    create(unique_index(:table_actions, [:table, :method], name: :table_method_index))
  end
end
