defmodule TodoListWeb.GroupLive.Show do
  use TodoListWeb, :live_view

  alias TodoList.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Group {@group.id}
        <:subtitle>This is a group record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/groups"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/groups/#{@group}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit group
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@group.name}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Group")
     |> assign(:group, Todos.get_group!(id))}
  end
end
