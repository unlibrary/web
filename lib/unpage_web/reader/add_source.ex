defmodule UnPageWeb.App.AddSource do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  alias UnPageWeb.ReaderView

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Add source")
      |> assign(:url, nil)
      |> assign(:name, nil)
      |> assign(:type, nil)

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def render(assigns) do
    render(ReaderView, "edit_source.html", assigns)
  end

  @impl true
  def handle_event(
        "save",
        %{"source" => %{"url" => url, "type" => type, "name" => name}},
        socket
      ) do
    type = String.to_existing_atom(type)
    {:ok, source} = make_call(UnLib.Sources.new(url, type, name))
    {:ok, user} = make_call(UnLib.Sources.add(source, user()))

    {:noreply, assign(socket, :user, user) |> push_navigate(to: ~p"/reader")}
  end
end
