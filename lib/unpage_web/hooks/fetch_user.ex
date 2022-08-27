defmodule UnPageWeb.Hooks.FetchUser do
  @moduledoc """
  LiveView hook to fetch current authenticated user and assign it.
  Assigns `nil` if user is not found.
  """
  import UnPage.Daemon
  use UnPageWeb, :live_hook

  def on_mount(_env, _params, _session, socket) do
    {:cont, assign(socket, :user, user())}
  end
end
