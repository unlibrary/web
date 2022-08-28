defmodule UnPageWeb.App.Source do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(id))

    socket =
      socket
      |> assign(:id, source.id)
      |> assign(:title, source.name)
      |> assign(:entries, make_call(UnLib.Entries.list_all(source)))

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def render(assigns) do
    render(UnPageWeb.ReaderView, "feed.html", assigns)
  end

  @impl true
  def handle_event("read-all", _value, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(socket.assigns.id))

    make_call(UnLib.Entries.read_all(source))
    entries = make_call(UnLib.Entries.list_all(source))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("prune", _value, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(socket.assigns.id))

    make_call(UnLib.Entries.prune(source))
    entries = make_call(UnLib.Entries.list_all(source))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("pull", _value, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(socket.assigns.id))

    make_call(UnLib.Feeds.pull(source))
    entries = make_call(UnLib.Entries.list_all(source))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("read", %{"id" => entry_id}, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(socket.assigns.id))
    {:ok, entry} = make_call(UnLib.Entries.get(entry_id))

    case entry do
      %{read?: false} -> make_call(UnLib.Entries.read(entry))
      _ -> {:ok, _entry} = make_call(UnLib.Entries.unread(entry))
    end

    entries = make_call(UnLib.Entries.list_all(source))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("delete", %{"id" => entry_id}, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(socket.assigns.id))

    :ok = make_call(UnLib.Entries.delete(entry_id))
    entries = make_call(UnLib.Entries.list_all(source))

    {:noreply, assign(socket, :entries, entries)}
  end
end
