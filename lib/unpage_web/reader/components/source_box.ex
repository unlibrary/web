defmodule UnPageWeb.App.Components.Source do
  @moduledoc """
  Phoenix component for rendering a nice box with information about a feed.
  """
  use UnPageWeb, :component

  def box(assigns) do
    ~H"""
    <div class="source-box">
      <img
        src={@source.icon}
        alt="Feed icon"
        onerror="this.src = '/images/rss.png'"
        class="feed-icon square"
      />
      <div>
        <p class="type"><%= @source.type %> feed</p>
        <.link navigate={~p"/reader/source/#{@source.id}"}>
          <h2 class="title">~<%= @source.name %></h2>
        </.link>
        <p class="url"><%= @source.url %></p>
      </div>
    </div>
    """
  end
end
