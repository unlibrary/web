defmodule UnPage.Daemon do
  @moduledoc """
  Handles interaction with `readerd` daemon.
  """

  @spec make_call(fun()) :: term()
  defmacro make_call(fun) do
    {{:__aliases__, _, modules}, fun, args} = Macro.decompose_call(fun)
    module = Module.concat(modules)
    server = get_server()

    quote do
      if online?() do
        :erpc.call(unquote(server), unquote(module), unquote(fun), unquote(args))
      else
        raise "reader daemon is not online"
      end
    end
  end

  defp get_server() do
    Application.fetch_env!(:unpage, :server)
  end

  @spec online? :: boolean()
  def online? do
    case Node.connect(get_server()) do
      :ignored -> false
      boolean -> boolean
    end
  end

  @spec logged_in? :: boolean()
  def logged_in? do
    make_call(UnLibD.Auth.logged_in?())
  end

  @spec user :: UnLib.Account.t()
  def user do
    make_call(UnLibD.Auth.current_user())
  end
end
