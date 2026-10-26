defmodule TodoList.Todos.TodList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :name, :string

    belongs_to :group, TodoList.Todos.Group

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tod_list, attrs) do
    tod_list
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
