defmodule UnPageWeb.Router do
  use UnPageWeb, :router
  alias UnPageWeb.Hooks

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

  live_session :pages, on_mount: [Hooks.FetchUser] do
    scope "/", UnPageWeb.Pages do
      pipe_through :browser

      live "/", Index
      live "/login", Login
    end
  end

  live_session :reader, on_mount: [Hooks.FetchUser, Hooks.RequireAuthenticatedUser] do
    scope "/reader", UnPageWeb.App do
      pipe_through :browser

      live "/", NewArticles
      live "/all", AllArticles
      live "/source/:id", Source
      live "/entry/:id", Entry
    end
  end
end
