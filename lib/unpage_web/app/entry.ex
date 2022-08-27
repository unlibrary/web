defmodule UnPageWeb.App.Entry do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, entry} = make_call(UnLib.Entries.get(id))

    {:ok, assign(socket, user: user(), entry: entry),
     layout: {UnPageWeb.LayoutView, "reader.html"}}
  end
end
