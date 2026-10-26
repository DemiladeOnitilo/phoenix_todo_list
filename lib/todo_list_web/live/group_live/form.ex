defmodule TodoListWeb.GroupLive.Form do
  use TodoListWeb, :live_view

  alias TodoList.Todos
  alias TodoList.Todos.Group

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage group records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="group-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Group</.button>
          <.button navigate={return_path(@return_to, @group)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    group = Todos.get_group!(id)

    socket
    |> assign(:page_title, "Edit Group")
    |> assign(:group, group)
    |> assign(:form, to_form(Todos.change_group(group)))
  end

  defp apply_action(socket, :new, _params) do
    group = %Group{}

    socket
    |> assign(:page_title, "New Group")
    |> assign(:group, group)
    |> assign(:form, to_form(Todos.change_group(group)))
  end

  @impl true
  def handle_event("validate", %{"group" => group_params}, socket) do
    changeset = Todos.change_group(socket.assigns.group, group_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"group" => group_params}, socket) do
    save_group(socket, socket.assigns.live_action, group_params)
  end

  defp save_group(socket, :edit, group_params) do
    case Todos.update_group(socket.assigns.group, group_params) do
      {:ok, group} ->
        {:noreply,
         socket
         |> put_flash(:info, "Group updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, group))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_group(socket, :new, group_params) do
    case Todos.create_group(group_params) do
      {:ok, group} ->
        {:noreply,
         socket
         |> put_flash(:info, "Group created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, group))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _group), do: ~p"/groups"
  defp return_path("show", group), do: ~p"/groups/#{group}"
end
