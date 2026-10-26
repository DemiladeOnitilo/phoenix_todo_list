defmodule TodoListWeb.TodListLive.Form do
  use TodoListWeb, :live_view

  alias TodoList.Todos
  alias TodoList.Todos.TodList

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage tod_list records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="tod_list-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Tod list</.button>
          <.button navigate={return_path(@return_to, @tod_list)}>Cancel</.button>
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
    tod_list = Todos.get_tod_list!(id)

    socket
    |> assign(:page_title, "Edit Tod list")
    |> assign(:tod_list, tod_list)
    |> assign(:form, to_form(Todos.change_tod_list(tod_list)))
  end

  defp apply_action(socket, :new, _params) do
    tod_list = %TodList{}

    socket
    |> assign(:page_title, "New Tod list")
    |> assign(:tod_list, tod_list)
    |> assign(:form, to_form(Todos.change_tod_list(tod_list)))
  end

  @impl true
  def handle_event("validate", %{"tod_list" => tod_list_params}, socket) do
    changeset = Todos.change_tod_list(socket.assigns.tod_list, tod_list_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"tod_list" => tod_list_params}, socket) do
    save_tod_list(socket, socket.assigns.live_action, tod_list_params)
  end

  defp save_tod_list(socket, :edit, tod_list_params) do
    case Todos.update_tod_list(socket.assigns.tod_list, tod_list_params) do
      {:ok, tod_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tod list updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, tod_list))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_tod_list(socket, :new, tod_list_params) do
    case Todos.create_tod_list(tod_list_params) do
      {:ok, tod_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tod list created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, tod_list))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _tod_list), do: ~p"/todos"
  defp return_path("show", tod_list), do: ~p"/todos/#{tod_list}"
end
