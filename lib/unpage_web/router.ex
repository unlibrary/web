defmodule UnPageWeb.Router do
  use UnPageWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {UnPageWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UnPageWeb.Pages do
    pipe_through :browser

    live "/", Index
  end

  scope "/reader", UnPageWeb.App do
    pipe_through :browser

    live "/", Feed
  end
end
