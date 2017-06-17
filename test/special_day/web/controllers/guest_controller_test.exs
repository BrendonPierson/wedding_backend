defmodule SD.Web.GuestControllerTest do
  use SD.Web.ConnCase

  alias SD.Wedding
  alias SD.Wedding.Guest

  @create_attrs %{attending: true, config: %{}, email: "some email", first_name: "some first_name", food_choice: "some food_choice", gift: "some gift", last_name: "some last_name", number_of_guests: 42, phone: "some phone", plus_one: true, rsvp_date: ~D[2010-04-17], send_updates: true, table: "some table", thank_you_sent: true, verified: true}
  @update_attrs %{attending: false, config: %{}, email: "some updated email", first_name: "some updated first_name", food_choice: "some updated food_choice", gift: "some updated gift", last_name: "some updated last_name", number_of_guests: 43, phone: "some updated phone", plus_one: false, rsvp_date: ~D[2011-05-18], send_updates: false, table: "some updated table", thank_you_sent: false, verified: false}
  @invalid_attrs %{attending: nil, config: nil, email: nil, first_name: nil, food_choice: nil, gift: nil, last_name: nil, number_of_guests: nil, phone: nil, plus_one: nil, rsvp_date: nil, send_updates: nil, table: nil, thank_you_sent: nil, verified: nil}

  def fixture(:guest) do
    {:ok, guest} = Wedding.create_guest(@create_attrs)
    guest
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, guest_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates guest and renders guest when data is valid", %{conn: conn} do
    conn = post conn, guest_path(conn, :create), guest: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, guest_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "attending" => true,
      "config" => %{},
      "email" => "some email",
      "first_name" => "some first_name",
      "food_choice" => "some food_choice",
      "gift" => "some gift",
      "last_name" => "some last_name",
      "number_of_guests" => 42,
      "phone" => "some phone",
      "plus_one" => true,
      "rsvp_date" => ~D[2010-04-17],
      "send_updates" => true,
      "table" => "some table",
      "thank_you_sent" => true,
      "verified" => true}
  end

  test "does not create guest and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, guest_path(conn, :create), guest: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen guest and renders guest when data is valid", %{conn: conn} do
    %Guest{id: id} = guest = fixture(:guest)
    conn = put conn, guest_path(conn, :update, guest), guest: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, guest_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "attending" => false,
      "config" => %{},
      "email" => "some updated email",
      "first_name" => "some updated first_name",
      "food_choice" => "some updated food_choice",
      "gift" => "some updated gift",
      "last_name" => "some updated last_name",
      "number_of_guests" => 43,
      "phone" => "some updated phone",
      "plus_one" => false,
      "rsvp_date" => ~D[2011-05-18],
      "send_updates" => false,
      "table" => "some updated table",
      "thank_you_sent" => false,
      "verified" => false}
  end

  test "does not update chosen guest and renders errors when data is invalid", %{conn: conn} do
    guest = fixture(:guest)
    conn = put conn, guest_path(conn, :update, guest), guest: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen guest", %{conn: conn} do
    guest = fixture(:guest)
    conn = delete conn, guest_path(conn, :delete, guest)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, guest_path(conn, :show, guest)
    end
  end
end
