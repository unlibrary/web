defmodule UnPageWeb.App.AddSource do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :page_title, "Add source")
    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def handle_event(
        "add",
        %{"source" => %{"url" => url, "type" => type, "name" => name}},
        socket
      ) do
    type = String.to_existing_atom(type)
    {:ok, source} = make_call(UnLib.Sources.new(url, type, name))
    {:ok, user} = make_call(UnLib.Sources.add(source, user()))

    {:noreply, assign(socket, :user, user)}
  end
end
