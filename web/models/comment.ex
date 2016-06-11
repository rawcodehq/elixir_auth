defmodule Blog.Comment do
  use Blog.Web, :model

  schema "comments" do
    field :post_id, :integer
    field :body, :string
    field :user_id, :integer

    timestamps
  end

  @required_fields ~w(post_id body user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
