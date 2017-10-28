defmodule Nerves.InitGadget.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    config_opts = Map.new(Application.get_all_env(:nerves_init_gadget))
    merged_opts = Map.merge(%Nerves.InitGadget.Options{}, config_opts)

    case merged_opts do
      # If address method is static, we want a dhcp server.
      %{address_method: :static} ->
        [
          worker(Nerves.InitGadget.NetworkManager, [merged_opts]),
          worker(DHCPServer, [merged_opts.ifname, []])
        ]
      # if link local, no dhcp server is needed.
      %{address_method: :link_local} ->
        [
          worker(Nerves.InitGadget.NetworkManager, [merged_opts]),
        ]
    end
    |> Supervisor.start_link([strategy: :one_for_one, name: Nerves.InitGadget.Supervisor])
  end
end
