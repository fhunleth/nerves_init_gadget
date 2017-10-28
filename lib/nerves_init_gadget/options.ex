defmodule Nerves.InitGadget.Options do
  @moduledoc false

  defstruct ifname: "usb0",
            address_method: :linklocal,
            ip_address: nil,
            ip_subnet_mask: nil,
            mdns_domain: "nerves.local",
            node_name: nil,
            node_host: :mdns_domain
end
