defmodule ExAcl.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add(:id, :string, primary_key: true)
      add(:is_active, :boolean, null: false, default: true)
      add(:description, :string, null: false)
      add(:constraints, :map, null: false, default: %{})
    end
  end
end
