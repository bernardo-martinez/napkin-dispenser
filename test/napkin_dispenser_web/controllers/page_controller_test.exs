defmodule NapkinDispenserWeb.PageControllerTest do
  use NapkinDispenserWeb.ConnCase

  alias Test.Support.Utils

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "napkin"
  end

  test "GET /:id", %{conn: conn} do
    id = Utils.generate_id()
    conn = get(conn, ~p"/#{id}")
    assert html_response(conn, 200) =~ "clear"
  end
end
