defmodule PlantMonitor.Web.Router do
  @moduledoc false
  use Plug.Router
  require Logger

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Logger
  plug PlantMonitor.Web.Redirects
  plug Plug.Static, at: "/", from: :plant_monitor

  plug Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison
  plug :match
  plug :dispatch

  # catch-all
  match _ do
    send_resp(conn, 404, "Resource not found")
  end

end
