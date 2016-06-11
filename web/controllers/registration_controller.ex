defmodule Blog.RegistrationController do
  use Blog.Web, :controller
  alias Blog.User

  def new(conn, _) do
    render conn, :new
  end

  def create(conn, %{"register" => register_params}) do
    # create the user
    user = Blog.User.changeset(%User{}, register_params)
    case Blog.Repo.insert(user) do
      {:ok, user} ->
        redirect(conn, to: "/")
      {:error, changeset} ->
        # add an error
        render conn, :new
    end
  end

end
