defmodule TodoListWeb.GroupLiveTest do
  use TodoListWeb.ConnCase

  import Phoenix.LiveViewTest
  import TodoList.TodosFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}
  defp create_group(_) do
    group = group_fixture()

    %{group: group}
  end

  describe "Index" do
    setup [:create_group]

    test "lists all groups", %{conn: conn, group: group} do
      {:ok, _index_live, html} = live(conn, ~p"/groups")

      assert html =~ "Listing Groups"
      assert html =~ group.name
    end

    test "saves new group", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/groups")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Group")
               |> render_click()
               |> follow_redirect(conn, ~p"/groups/new")

      assert render(form_live) =~ "New Group"

      assert form_live
             |> form("#group-form", group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#group-form", group: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/groups")

      html = render(index_live)
      assert html =~ "Group created successfully"
      assert html =~ "some name"
    end

    test "updates group in listing", %{conn: conn, group: group} do
      {:ok, index_live, _html} = live(conn, ~p"/groups")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#groups-#{group.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/groups/#{group}/edit")

      assert render(form_live) =~ "Edit Group"

      assert form_live
             |> form("#group-form", group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#group-form", group: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/groups")

      html = render(index_live)
      assert html =~ "Group updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes group in listing", %{conn: conn, group: group} do
      {:ok, index_live, _html} = live(conn, ~p"/groups")

      assert index_live |> element("#groups-#{group.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#groups-#{group.id}")
    end
  end

  describe "Show" do
    setup [:create_group]

    test "displays group", %{conn: conn, group: group} do
      {:ok, _show_live, html} = live(conn, ~p"/groups/#{group}")

      assert html =~ "Show Group"
      assert html =~ group.name
    end

    test "updates group and returns to show", %{conn: conn, group: group} do
      {:ok, show_live, _html} = live(conn, ~p"/groups/#{group}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/groups/#{group}/edit?return_to=show")

      assert render(form_live) =~ "Edit Group"

      assert form_live
             |> form("#group-form", group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#group-form", group: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/groups/#{group}")

      html = render(show_live)
      assert html =~ "Group updated successfully"
      assert html =~ "some updated name"
    end
  end
end
