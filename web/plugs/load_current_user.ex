defmodule Blog.LoadCurrentUser do
  # pass config
  def init(opts) do
    opts
  end

  # when you a get a request
  def call(conn, opts) do
    user_id = Plug.Conn.get_session(conn, :user_id)

    if user_id do
      user = Blog.Repo.get(Blog.User, user_id)
      Plug.Conn.assign(conn, :current_user, user)
    else
      conn
    end
  end
end
