defmodule Blog.LayoutView do
  use Blog.Web, :view

  def user_signed_in?(conn) do
    !!conn.assigns[:current_user]
  end

end
