defmodule TodoList.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias TodoList.Repo

  alias TodoList.Todos.Group

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  alias TodoList.Todos.TodList

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%TodList{}, ...]

  """
  def list_todos do
    Repo.all(TodList)
  end

  @doc """
  Gets a single tod_list.

  Raises `Ecto.NoResultsError` if the Tod list does not exist.

  ## Examples

      iex> get_tod_list!(123)
      %TodList{}

      iex> get_tod_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tod_list!(id), do: Repo.get!(TodList, id)

  @doc """
  Creates a tod_list.

  ## Examples

      iex> create_tod_list(%{field: value})
      {:ok, %TodList{}}

      iex> create_tod_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tod_list(attrs) do
    %TodList{}
    |> TodList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tod_list.

  ## Examples

      iex> update_tod_list(tod_list, %{field: new_value})
      {:ok, %TodList{}}

      iex> update_tod_list(tod_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tod_list(%TodList{} = tod_list, attrs) do
    tod_list
    |> TodList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tod_list.

  ## Examples

      iex> delete_tod_list(tod_list)
      {:ok, %TodList{}}

      iex> delete_tod_list(tod_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tod_list(%TodList{} = tod_list) do
    Repo.delete(tod_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tod_list changes.

  ## Examples

      iex> change_tod_list(tod_list)
      %Ecto.Changeset{data: %TodList{}}

  """
  def change_tod_list(%TodList{} = tod_list, attrs \\ %{}) do
    TodList.changeset(tod_list, attrs)
  end

  alias TodoList.Todos.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
