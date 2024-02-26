defmodule NapkinDispenserWeb.PageController do
  use NapkinDispenserWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, layout: false, id: id)
  end
end
