defmodule NapkinDispenserWeb.PageController do
  use NapkinDispenserWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/#{Elixir.UUID.uuid4()}")
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, layout: false, id: id)
  end
end
