defmodule TodoList.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :completed, :boolean, default: false, null: false
      add :todo_id, references(:todos, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:tasks, [:todo_id])
  end
end
