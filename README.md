# PlantMonitor

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves


## Notes

### SPI

    iex> alias ElixirALE.SPI
    iex> {:ok, pid} = SPI.start_link "spidev0.0"
    {:ok, #PID<0.123.0>}

Send bit stream `1100 0000 0000 0000`.

    iex> SPI.transfer pid, <<192, 0>>
    <<1, 23>>
    iex> <<_::size(6), counts::size(10)>> = SPI.transfer pid, <<192, 0>>
    <<1, 234>>
    iex> count
    490

