defmodule FileServer.HTTP do
  require Logger
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  match "/*_" do
    {resp_code, resp_body} = case conn.method do
      "GET" -> handle_get(conn)
      "PUT" -> handle_put(conn)
      _ -> {405, "Method not allowed. Allowed methods: [GET, PUT]"}
    end

    send_resp(conn, resp_code, resp_body)
  end

  def handle_get(conn) do
    path = Application.get_env(:file_server, :root_dir) <> conn.request_path
    Logger.debug("GET path #{path}")

    if File.exists?(path) do
      resp = if File.dir?(path) do
        # return ls of the requested path
        :os.cmd('ls -AF #{path}')
      else
        # return the requested file
        path |> File.read!()
      end
      {200, resp}
    else
      {404, "404 - Not Found"}
    end
  end

  def handle_put(conn) do
    # 9_000_000_000 bytes == 8583 mb, is our maximum body size
    case Plug.Conn.read_body(conn, [length: 9_000_000_000]) do
      {:error, reason}   -> {500, "Unable to read request body: {:error, #{reason}}"}
      {:more, _, _}      -> {413, "Request body is too long"}
      {:ok, body, _conn} ->
        path = Application.get_env(:file_server, :root_dir) <> conn.request_path
        Logger.debug("PUT file to path #{path}")

        # create subdirs if needed
        File.mkdir_p!(Path.dirname(path))

        # create uploaded file
        case File.write(path, body) do
          {:error, reason} -> {500, "Unable to write file: {:error, #{reason}}"}
          :ok -> {200, "File uploaded"}
        end
      end
  end
end
