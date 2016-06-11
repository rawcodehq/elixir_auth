defmodule Blog.RoomChannel do
  use Blog.Web, :channel
  #use Guardian.Phoenix.Socket


  #def join("rooms:" <> post_id, message, socket) do
    #IO.inspect [message, post_id]
    #{:ok, socket}
  #end

  def join("rooms:" <> post_id, message, socket) do
    IO.inspect [message, post_id]
    {:ok, socket}
  end

  def handle_in("new_comment", %{"body" => body}, socket) do
    "rooms:" <> post_id = socket.topic
    {post_id, ""} = Integer.parse(post_id)
    user = Guardian.Phoenix.Socket.current_resource(socket)
    Blog.Repo.insert %Blog.Comment{body: body, user_id: user.id, post_id: post_id}
    {:noreply, socket}
  end
end
