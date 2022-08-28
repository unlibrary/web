defmodule UnPageWeb.Hooks.RequireAuthenticatedUser do
  @moduledoc """
  LiveView hook to check wether authenticated user is set and
  navigate to login if it isn't.
  """
  use UnPageWeb, :live_hook

  def on_mount(_env, _params, _session, socket) do
    if socket.assigns.user do
      {:cont, socket}
    else
      {:halt, push_navigate(socket, to: ~p"/login")}
    end
  end
end
