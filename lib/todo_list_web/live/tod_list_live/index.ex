defmodule TodoListWeb.TodListLive.Index do
  use TodoListWeb, :live_view

  alias TodoList.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Todos
        <:actions>
          <.button variant="primary" navigate={~p"/todos/new"}>
            <.icon name="hero-plus" /> New Tod list
          </.button>
        </:actions>
      </.header>

      <.table
        id="todos"
        rows={@streams.todos}
        row_click={fn {_id, tod_list} -> JS.navigate(~p"/todos/#{tod_list}") end}
      >
        <:col :let={{_id, tod_list}} label="Name">{tod_list.name}</:col>
        <:action :let={{_id, tod_list}}>
          <div class="sr-only">
            <.link navigate={~p"/todos/#{tod_list}"}>Show</.link>
          </div>
          <.link navigate={~p"/todos/#{tod_list}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, tod_list}}>
          <.link
            phx-click={JS.push("delete", value: %{id: tod_list.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Todos")
     |> stream(:todos, list_todos())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tod_list = Todos.get_tod_list!(id)
    {:ok, _} = Todos.delete_tod_list(tod_list)

    {:noreply, stream_delete(socket, :todos, tod_list)}
  end

  defp list_todos() do
    Todos.list_todos()
  end
end
