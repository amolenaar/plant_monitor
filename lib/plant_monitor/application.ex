defmodule PlantMonitor.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do

    network_time()
    :dnssd.register("plant monitor", "_http._tcp", 80)

    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # worker(PlantMonitor.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlantMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def network_time do
    {_, 0} = System.cmd("/usr/sbin/ntpd", ["-g"])
    :ok
  end

end
