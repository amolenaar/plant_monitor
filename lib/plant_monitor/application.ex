defmodule PlantMonitor.Application do
  use Application

  alias PlantMonitor.Regelaar
  alias PlantMonitor.Web.Router
  alias Plug.Adapters.Cowboy

  def start(_type, _args) do

    import Supervisor.Spec, warn: false

    port = Application.get_env(:plant_monitor, :port, 8080)

    :dnssd.register("Plant Monitor", "_http._tcp", port)

    children = [
      Cowboy.child_spec(:http, Router, [], port: port, acceptors: 10),
      {Regelaar, []}
    ]

    opts = [strategy: :one_for_one, name: PlantMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
