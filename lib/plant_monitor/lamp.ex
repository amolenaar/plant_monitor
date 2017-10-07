defmodule PlantMonitor.Lamp do
  use GenServer

  alias ElixirALE.GPIO
  alias PlantMonitor.Lamp
  
  defstruct gpio: nil

  def new() do
    {:ok, pid} = GPIO.start_link(2, :output)

    %Lamp{gpio: pid}
  end

  def aan(lamp) do
    GPIO.write(lamp.gpio, 1)
  end

  def uit(lamp) do
    GPIO.write(lamp.gpio, 0)
  end

end
