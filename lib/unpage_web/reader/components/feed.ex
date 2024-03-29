defmodule UnPageWeb.App.Components.Feed do
  @moduledoc """
  Phoenix component to render a list of posts from a source and feed control buttons.
  """
  use UnPageWeb, :component

  def controls(assigns) do
    ~H"""
    <div class="flex gap:.5" style="margin-inline-end: var(--s1)">
      <button class="the-icon-parent button-small inline" phx-click="read-all">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="icon">
          <path
            fill-rule="evenodd"
            d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
            clip-rule="evenodd"
          />
        </svg>
        Mark all as read
      </button>

      <button class="the-icon-parent button-small inline" phx-click="prune">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="icon"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0"
          />
        </svg>
        Delete read posts
      </button>
      <button class="button-small inline" phx-click="pull" title="Pull new posts">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="icon">
          <path
            fill-rule="evenodd"
            d="M12 5.25c-1.213 0-2.415.046-3.605.135a3.256 3.256 0 00-3.01 3.01c-.044.583-.077 1.17-.1 1.759L6.97 8.47a.75.75 0 011.06 1.06l-3 3a.75.75 0 01-1.06 0l-3-3a.75.75 0 011.06-1.06l1.752 1.751c.023-.65.06-1.296.108-1.939A4.756 4.756 0 018.282 3.89a49.423 49.423 0 017.436 0 4.756 4.756 0 014.392 4.392c.017.224.032.447.046.672a.75.75 0 01-1.497.092 48.187 48.187 0 00-.044-.651 3.256 3.256 0 00-3.01-3.01A47.926 47.926 0 0012 5.25zm6.97 6.22a.75.75 0 011.06 0l3 3a.75.75 0 11-1.06 1.06l-1.752-1.751a49.25 49.25 0 01-.108 1.939 4.756 4.756 0 01-4.392 4.392 49.412 49.412 0 01-7.436 0 4.756 4.756 0 01-4.392-4.392 49.112 49.112 0 01-.046-.672.75.75 0 111.497-.092c.013.217.028.434.044.651a3.256 3.256 0 003.01 3.01 47.951 47.951 0 007.21 0 3.256 3.256 0 003.01-3.01c.044-.583.077-1.17.1-1.759L17.03 15.53a.75.75 0 11-1.06-1.06l3-3z"
            clip-rule="evenodd"
          />
        </svg>
      </button>
    </div>
    """
  end

  def list(assigns) do
    ~H"""
    <table class="feed width:full">
      <thead class="width:full">
        <tr>
          <th>Title</th>
          <th>Date</th>
        </tr>
      </thead>
      <tbody class="width:full">
        <%= for entry <- @entries do %>
          <tr class={if entry.read?, do: "read"}>
            <td>
              <.link navigate={"/reader/entry/#{entry.id}"}><%= entry.title %></.link>
            </td>
            <td>
              <%= entry.date |> Calendar.strftime("%Y-%m-%d") %>
            </td>
            <td class="flex flex-row gap:.5">
              <%= if @show_controls? do %>
                <.small_controls entry_id={entry.id} />
              <% end %>
            </td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  def small_controls(assigns) do
    ~H"""
    <button class="button-small square" phx-click="toggle-read-entry" phx-value-id={@entry_id} title="Mark as read">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="icon">
        <path
          fill-rule="evenodd"
          d="M19.916 4.626a.75.75 0 01.208 1.04l-9 13.5a.75.75 0 01-1.154.114l-6-6a.75.75 0 011.06-1.06l5.353 5.353 8.493-12.739a.75.75 0 011.04-.208z"
          clip-rule="evenodd"
        />
      </svg>
    </button>
    <button class="button-small square" phx-click="delete-entry" phx-value-id={@entry_id} title="Delete">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="icon">
        <path
          fill-rule="evenodd"
          d="M16.5 4.478v.227a48.816 48.816 0 013.878.512.75.75 0 11-.256 1.478l-.209-.035-1.005 13.07a3 3 0 01-2.991 2.77H8.084a3 3 0 01-2.991-2.77L4.087 6.66l-.209.035a.75.75 0 01-.256-1.478A48.567 48.567 0 017.5 4.705v-.227c0-1.564 1.213-2.9 2.816-2.951a52.662 52.662 0 013.369 0c1.603.051 2.815 1.387 2.815 2.951zm-6.136-1.452a51.196 51.196 0 013.273 0C14.39 3.05 15 3.684 15 4.478v.113a49.488 49.488 0 00-6 0v-.113c0-.794.609-1.428 1.364-1.452zm-.355 5.945a.75.75 0 10-1.5.058l.347 9a.75.75 0 101.499-.058l-.346-9zm5.48.058a.75.75 0 10-1.498-.058l-.347 9a.75.75 0 001.5.058l.345-9z"
          clip-rule="evenodd"
        />
      </svg>
    </button>
    """
  end
end
