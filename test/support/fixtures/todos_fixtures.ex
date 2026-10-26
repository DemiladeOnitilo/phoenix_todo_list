defmodule TodoList.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoList.Todos` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TodoList.Todos.create_group()

    group
  end

  @doc """
  Generate a tod_list.
  """
  def tod_list_fixture(attrs \\ %{}) do
    {:ok, tod_list} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TodoList.Todos.create_tod_list()

    tod_list
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        description: "some description",
        title: "some title"
      })
      |> TodoList.Todos.create_task()

    task
  end
end
