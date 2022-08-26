defmodule UnPageWeb.App.Feed do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, user: user(), entries: make_call(UnLib.Entries.list(user()))),
     layout: {UnPageWeb.LayoutView, "reader.html"}}
  end
end
