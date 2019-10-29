defmodule FileServer.App do
  use Application
  require Logger

  def start(_type, _args) do
    [{main_ip, main_port} | _] = addresses = Application.get_env(:file_server, :http)
    Logger.info("Started File Server at http://#{main_ip}:#{main_port}")
    Logger.info("Serving dir #{Application.get_env(:file_server, :root_dir)}")
    children = for {ip, port} <- addresses do
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: FileServer.HTTP,
        options: [port: port],
        protocol_options: [idle_timeout: 60_000],
        ip: elem(:inet.parse_address('#{ip}'), 1),
        ref: {ip, port}
      )
    end
    opts = [strategy: :one_for_one, name: FileServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
