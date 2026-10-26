defmodule TodoList.TodosTest do
  use TodoList.DataCase

  alias TodoList.Todos

  describe "groups" do
    alias TodoList.Todos.Group

    import TodoList.TodosFixtures

    @invalid_attrs %{name: nil}

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Todos.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Todos.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Group{} = group} = Todos.create_group(valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Group{} = group} = Todos.update_group(group, update_attrs)
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_group(group, @invalid_attrs)
      assert group == Todos.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Todos.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Todos.change_group(group)
    end
  end

  describe "todos" do
    alias TodoList.Todos.TodList

    import TodoList.TodosFixtures

    @invalid_attrs %{name: nil}

    test "list_todos/0 returns all todos" do
      tod_list = tod_list_fixture()
      assert Todos.list_todos() == [tod_list]
    end

    test "get_tod_list!/1 returns the tod_list with given id" do
      tod_list = tod_list_fixture()
      assert Todos.get_tod_list!(tod_list.id) == tod_list
    end

    test "create_tod_list/1 with valid data creates a tod_list" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %TodList{} = tod_list} = Todos.create_tod_list(valid_attrs)
      assert tod_list.name == "some name"
    end

    test "create_tod_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_tod_list(@invalid_attrs)
    end

    test "update_tod_list/2 with valid data updates the tod_list" do
      tod_list = tod_list_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %TodList{} = tod_list} = Todos.update_tod_list(tod_list, update_attrs)
      assert tod_list.name == "some updated name"
    end

    test "update_tod_list/2 with invalid data returns error changeset" do
      tod_list = tod_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_tod_list(tod_list, @invalid_attrs)
      assert tod_list == Todos.get_tod_list!(tod_list.id)
    end

    test "delete_tod_list/1 deletes the tod_list" do
      tod_list = tod_list_fixture()
      assert {:ok, %TodList{}} = Todos.delete_tod_list(tod_list)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_tod_list!(tod_list.id) end
    end

    test "change_tod_list/1 returns a tod_list changeset" do
      tod_list = tod_list_fixture()
      assert %Ecto.Changeset{} = Todos.change_tod_list(tod_list)
    end
  end

  describe "tasks" do
    alias TodoList.Todos.Task

    import TodoList.TodosFixtures

    @invalid_attrs %{description: nil, title: nil, completed: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todos.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todos.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{description: "some description", title: "some title", completed: true}

      assert {:ok, %Task{} = task} = Todos.create_task(valid_attrs)
      assert task.description == "some description"
      assert task.title == "some title"
      assert task.completed == true
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", completed: false}

      assert {:ok, %Task{} = task} = Todos.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.title == "some updated title"
      assert task.completed == false
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_task(task, @invalid_attrs)
      assert task == Todos.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todos.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todos.change_task(task)
    end
  end
end
