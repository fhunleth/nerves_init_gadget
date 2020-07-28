defmodule Nerves.InitGadget.Options do
  @moduledoc false

  alias Nerves.InitGadget.Options

  defstruct ifname: "usb0",
            address_method: :dhcpd,
            mdns_name: "Nerves Gadget",
            mdns_domain: "nerves.local",
            mdns_ttl: 120,
            node_name: nil,
            node_host: :mdns_domain,
            ssh_console_port: 22

  def get() do
    :nerves_init_gadget
    |> Application.get_all_env()
    |> Enum.into(%{})
    |> merge_defaults()
  end

  defp merge_defaults(settings) do
    Map.merge(%Options{}, settings)
  end
end
