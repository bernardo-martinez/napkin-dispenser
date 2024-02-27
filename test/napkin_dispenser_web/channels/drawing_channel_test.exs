defmodule NapkinDispenserWeb.DrawingChannelTest do
  use NapkinDispenserWeb.ChannelCase

  alias Test.Support.Utils

  setup do
    user_id = Utils.generate_id()
    napkin_id = Utils.generate_id()
    {:ok, _, socket} =
      NapkinDispenserWeb.UserSocket
      |> socket(user_id, %{})
      |> subscribe_and_join(NapkinDispenserWeb.DrawingChannel, "drawing:#{napkin_id}")

    %{socket: socket}
  end

  test "broadcasts stroke", %{socket: socket} do
    push(socket, "stroke", %{"body" => "test"})
    assert_broadcast "stroke", %{body: "test"}
  end

  test "broadcasts clear", %{socket: socket} do
    push(socket, "clear", %{})
    assert_broadcast "clear", %{}
  end
end
