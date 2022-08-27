defmodule UnPageWeb.App.Feed do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user, user()), layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def handle_params(_params, url, socket) do
    entries =
      cond do
        String.contains?(url, "unread") ->
          make_call(UnLib.Entries.list(user()))

        true ->
          make_call(UnLib.Entries.list_all(user()))
      end

    {:noreply, assign(socket, :entries, entries)}
  end
end
