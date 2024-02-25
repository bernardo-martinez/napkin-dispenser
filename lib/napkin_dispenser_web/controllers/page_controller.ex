defmodule NapkinDispenserWeb.PageController do
  use NapkinDispenserWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, layout: false, id: id)
  end
end
