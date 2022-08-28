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
        <div class="flex flex-row items:center gap:.5">
        <h2 class="title">
          <.link navigate={~p"/reader/source/#{@source.id}"}>
            ~<%= @source.name %>
          </.link>

        </h2>
        <%= if @allow_edit? do %>
        <.link
            class="button-small size:small inline"
            navigate={~p"/reader/source/#{@source.id}/edit"}
          >
            edit
          </.link>
        <% end %>
        </div>
        <p class="url"><%= @source.url %></p>
      </div>
    </div>
    """
  end
end
