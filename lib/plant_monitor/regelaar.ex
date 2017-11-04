defmodule PlantMonitor.Regelaar do
    use GenServer

    alias PlantMonitor.Vocht
    alias PlantMonitor.Lamp

    def start_link(_args \\ []) do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end

    def init([]) do
        vocht = Vocht.new()
        lamp = Lamp.new()

        regel(vocht, lamp)
        {:ok, {vocht, lamp}, 5_000}
    end
    
    def handle_info(:timeout, {vocht, lamp}) do
        regel(vocht, lamp)
        {:noreply, {vocht, lamp}, 5_000}
    end

    def regel(vocht, lamp) do
        vochtigheid = Vocht.meet vocht
        regel_lampje(vochtigheid, lamp)
    end

    def regel_lampje(vocht, lampje) when vocht > 200 do
        Lamp.uit lampje
    end

    def regel_lampje(_vocht, lampje) do
        Lamp.aan lampje
    end
end