defmodule TodoListWeb.TodListLive.Show do
  use TodoListWeb, :live_view

  alias TodoList.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Tod list {@tod_list.id}
        <:subtitle>This is a tod_list record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/todos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/todos/#{@tod_list}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit tod_list
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@tod_list.name}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Tod list")
     |> assign(:tod_list, Todos.get_tod_list!(id))}
  end
end
