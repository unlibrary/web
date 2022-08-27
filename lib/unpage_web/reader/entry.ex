defmodule UnPageWeb.App.Entry do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, entry} = make_call(UnLib.Entries.get(id))
    {:ok, entry} = make_call(UnLib.Entries.read(entry))

    socket =
      socket
      |> assign(:user, user())
      |> assign(:title, entry.title)
      |> assign(:body, entry.body |> HtmlSanitizeEx.html5())
      |> assign(:url, entry.url)
      |> assign(:author, entry.source.name)

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end
end
