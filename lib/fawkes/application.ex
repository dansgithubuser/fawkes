defmodule Fawkes.Application do
  use Application

  require Logger

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Logger.info "creating fawkes_table"
    :ets.new(:fawkes_table, [:named_table, :public])

    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(FawkesWeb.Endpoint, []),
      # Start your own worker by calling: Fawkes.Worker.start_link(arg1, arg2, arg3)
      # worker(Fawkes.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fawkes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FawkesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
