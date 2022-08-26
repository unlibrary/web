defmodule UnPage.Application do
  @moduledoc false
  use Application

  @opts strategy: :one_for_one, name: UnPage.Supervisor

  @impl true
  def start(_type, _args) do
    children = [
      UnPageWeb.Telemetry,
      {Phoenix.PubSub, name: UnPage.PubSub},
      UnPageWeb.Endpoint
    ]

    Supervisor.start_link(children, @opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    UnPageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
