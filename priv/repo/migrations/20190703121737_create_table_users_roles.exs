defmodule PhEctoAcl.Migrations.CreateTableUserRoles do
  use Ecto.Migration

  def change do
    create table(:users_roles, primary_key: false) do
      add(:user_id, references(:users), null: false, primary_key: true)

      add(:role_id, references(:roles, column: :id, type: :string), null: false, primary_key: true)
    end
  end
end
