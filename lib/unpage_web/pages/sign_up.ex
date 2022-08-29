defmodule UnPageWeb.Pages.SignUp do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:error, nil)
      |> assign(:page_title, "Sign up")

    {:ok, socket, layout: {UnPageWeb.LayoutView, "page.html"}}
  end

  @impl true
  def handle_event(
        "signup",
        %{"signup" => %{"password" => password, "username" => username}},
        socket
      ) do
    socket =
      case make_call(UnLib.Accounts.create(username, password)) do
        {:ok, _account} ->
          make_call(UnLibD.Auth.login(username, password))
          push_navigate(socket, to: ~p"/reader")

        {:error, _error} ->
          assign(socket, :error, "username already exists")
      end

    {:noreply, socket}
  end
end
