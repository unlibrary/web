defmodule UnPageWeb.App.EditSource do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(id))

    socket =
      socket
      |> assign(:page_title, "Edit source")
      |> assign(:url, source.url)
      |> assign(:name, source.name)
      |> assign(:type, source.type)

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def handle_event(
        "save",
        %{"source" => %{"url" => url, "type" => type, "name" => name}},
        socket
      ) do
    type = String.to_existing_atom(type)
    {:ok, source} = make_call(UnLib.Sources.new(url, type, name))

    {:noreply, assign(socket, user: user(), url: source.url, name: source.name, type: source.type)}
  end
end
