defmodule NapkinDispenserWeb.DrawingChannel do
  use Phoenix.Channel

  def join("drawing:" <> _id, _message, socket) do
    {:ok, socket}
  end

  def handle_in("stroke", %{"body" => body}, socket) do
    broadcast!(socket, "stroke", %{body: body})
    {:noreply, socket}
  end

  def handle_in("clear", _payload, socket) do
    broadcast!(socket, "clear", %{})
    {:noreply, socket}
  end
end
