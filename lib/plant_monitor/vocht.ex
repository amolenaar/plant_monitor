defmodule PlantMonitor.Vocht do
  use GenServer

  alias ElixirALE.SPI
  alias PlantMonitor.Vocht
  
  defstruct spi: nil

  def new() do
    {:ok, pid} = SPI.start_link "spidev0.0"

    %Vocht{spi: pid}
  end

  def meet(vocht) do
    <<_::size(6), waarde::size(10)>> = SPI.transfer vocht.spi, <<192, 0>>
    waarde
  end

end
