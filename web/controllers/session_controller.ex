defmodule Blog.SessionController do
  use Blog.Web, :controller

  def new(conn, _) do
    render conn, :new
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    # validate that the input is valid
    {valid, user} = Blog.User.valid_authentication?(email, password)
    if valid do
      # save this so that other requests can use this info
      conn
      |> put_session(:user_id, user.id)
      |> redirect(to: "/")
    else
      # TODO: add error msg
      render conn, :new
    end
  end
end
