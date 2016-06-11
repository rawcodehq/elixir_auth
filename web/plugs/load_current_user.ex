defmodule Blog.LoadCurrentUser do
  # pass config
  def init(opts) do
    opts
  end

  # when you a get a request
  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)
    Plug.Conn.assign(conn, :current_user, current_user)
  end
end
