defmodule NapkinDispenserWeb.DrawingChannelTest do
  use NapkinDispenserWeb.ChannelCase

  alias NapkinDispenserWeb.DrawingChannel
  alias NapkinDispenserWeb.UserSocket
  alias Test.Support.Utils

  setup do
    user_id = Utils.generate_id()
    socket = socket(UserSocket, user_id, %{})

    %{socket: socket}
  end

  test "broadcasts draw", %{socket: socket} do
    napkin_id = Utils.generate_id()

    {:ok, _, socket} = subscribe_and_join(socket, DrawingChannel, "drawing:#{napkin_id}")

    push(socket, "draw", %{"body" => "test"})

    assert_broadcast "draw", %{"body" => "test"}
  end

  test "broadcasts clear", %{socket: socket} do
    napkin_id = Utils.generate_id()

    {:ok, _, socket} = subscribe_and_join(socket, DrawingChannel, "drawing:#{napkin_id}")

    push(socket, "clear", %{})
    assert_broadcast "clear", %{}
  end

  test "if master joins, only socket is returned", %{socket: socket} do
    napkin_id = Utils.generate_id()

    assert {:ok, %{}, _socket} =
             subscribe_and_join(socket, DrawingChannel, "drawing:#{napkin_id}", %{
               "isMaster" => true
             })
  end

  test "if not joining as master and presence is empty, returns is_master=true in reply", %{
    socket: socket
  } do
    napkin_id = Utils.generate_id()

    assert {:ok, %{is_master: true}, _socket} =
             subscribe_and_join(
               socket,
               DrawingChannel,
               "drawing:#{napkin_id}"
             )
  end

  test "if not joining as master and presence is not empty, returns is_master=false in reply", %{
    socket: socket
  } do
    napkin_id = Utils.generate_id()
    another_user_id = Utils.generate_id()

    UserSocket
    |> socket(another_user_id, %{})
    |> subscribe_and_join("drawing:#{napkin_id}", %{"isMaster" => true})

    assert {:ok, %{is_master: false}, _socket} =
             subscribe_and_join(
               socket,
               DrawingChannel,
               "drawing:#{napkin_id}"
             )
  end

  test "pushes presence state after master joins", %{socket: socket} do
    napkin_id = Utils.generate_id()

    {:ok, _, _socket} =
      subscribe_and_join(socket, DrawingChannel, "drawing:#{napkin_id}", %{"isMaster" => true})

    assert_push "presence_state", %{}
  end

  test "pushes presence state after non master joins", %{socket: socket} do
    napkin_id = Utils.generate_id()

    {:ok, _, _socket} = subscribe_and_join(socket, DrawingChannel, "drawing:#{napkin_id}")

    assert_push "presence_state", %{}
  end
end
