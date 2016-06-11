defmodule Blog.User do
  use Blog.Web, :model

  alias Blog.User
  alias Blog.Repo

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :role, :string

    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w(encrypted_password role)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    encrypted_password = Comeonin.Bcrypt.hashpwsalt(password)
    put_change(changeset, :encrypted_password, encrypted_password)
  end

  def valid_authentication?(email, password) do
    case Repo.get_by(User, email: email) do
      nil ->
        {Comeonin.Bcrypt.dummy_checkpw(), nil}
      user ->
        {Comeonin.Bcrypt.checkpw(password, user.encrypted_password), user}
    end
  end
end
