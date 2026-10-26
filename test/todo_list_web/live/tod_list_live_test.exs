defmodule TodoListWeb.TodListLiveTest do
  use TodoListWeb.ConnCase

  import Phoenix.LiveViewTest
  import TodoList.TodosFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}
  defp create_tod_list(_) do
    tod_list = tod_list_fixture()

    %{tod_list: tod_list}
  end

  describe "Index" do
    setup [:create_tod_list]

    test "lists all todos", %{conn: conn, tod_list: tod_list} do
      {:ok, _index_live, html} = live(conn, ~p"/todos")

      assert html =~ "Listing Todos"
      assert html =~ tod_list.name
    end

    test "saves new tod_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/todos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Tod list")
               |> render_click()
               |> follow_redirect(conn, ~p"/todos/new")

      assert render(form_live) =~ "New Tod list"

      assert form_live
             |> form("#tod_list-form", tod_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#tod_list-form", tod_list: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/todos")

      html = render(index_live)
      assert html =~ "Tod list created successfully"
      assert html =~ "some name"
    end

    test "updates tod_list in listing", %{conn: conn, tod_list: tod_list} do
      {:ok, index_live, _html} = live(conn, ~p"/todos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#todos-#{tod_list.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/todos/#{tod_list}/edit")

      assert render(form_live) =~ "Edit Tod list"

      assert form_live
             |> form("#tod_list-form", tod_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#tod_list-form", tod_list: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/todos")

      html = render(index_live)
      assert html =~ "Tod list updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes tod_list in listing", %{conn: conn, tod_list: tod_list} do
      {:ok, index_live, _html} = live(conn, ~p"/todos")

      assert index_live |> element("#todos-#{tod_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#todos-#{tod_list.id}")
    end
  end

  describe "Show" do
    setup [:create_tod_list]

    test "displays tod_list", %{conn: conn, tod_list: tod_list} do
      {:ok, _show_live, html} = live(conn, ~p"/todos/#{tod_list}")

      assert html =~ "Show Tod list"
      assert html =~ tod_list.name
    end

    test "updates tod_list and returns to show", %{conn: conn, tod_list: tod_list} do
      {:ok, show_live, _html} = live(conn, ~p"/todos/#{tod_list}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/todos/#{tod_list}/edit?return_to=show")

      assert render(form_live) =~ "Edit Tod list"

      assert form_live
             |> form("#tod_list-form", tod_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#tod_list-form", tod_list: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/todos/#{tod_list}")

      html = render(show_live)
      assert html =~ "Tod list updated successfully"
      assert html =~ "some updated name"
    end
  end
end
