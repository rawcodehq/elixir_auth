defmodule Blog.EnsureAdmin do
  # pass config
  def init(opts) do
    opts
  end

  # when you a get a request
  def call(conn, _opts) do
    user = conn.assigns.current_user

    if user && user.role == "admin" do
      conn
    else
      conn
      |> Plug.Conn.halt
      |> Phoenix.Controller.put_flash(:error, "Unauthorized, needs to be an admin" )
      |> Phoenix.Controller.redirect(to: "/")
    end
  end
end

