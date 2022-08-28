defmodule UnPageWeb.Pages.Login do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:error, nil)
      |> assign(:page_title, "Login")

    {:ok, socket, layout: {UnPageWeb.LayoutView, "page.html"}}
  end

  @impl true
  def handle_event(
        "login",
        %{"login" => %{"password" => password, "username" => username}},
        socket
      ) do
    socket =
      case make_call(UnLibD.Auth.login(username, password)) do
        :ok ->
          push_navigate(socket, to: ~p"/reader")

        error ->
          assign(socket, :error, format_error(error))
      end

    {:noreply, socket}
  end

  defp format_error(error) do
    case error do
      :invalid_password -> "incorrect username or password"
      :no_user_found -> "account doesn't exist"
    end
  end
end
