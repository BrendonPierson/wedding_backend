defmodule SD.Web.InvitationControllerTest do
  use SD.Web.ConnCase

  alias SD.Wedding
  alias SD.Wedding.Invitation

  @create_attrs %{address_one: "some address_one", address_two: "some address_two", city: "some city", number_of_guests: 42, responded: true, sent: true, state: "some state", zip: "some zip"}
  @update_attrs %{address_one: "some updated address_one", address_two: "some updated address_two", city: "some updated city", number_of_guests: 43, responded: false, sent: false, state: "some updated state", zip: "some updated zip"}
  @invalid_attrs %{address_one: nil, address_two: nil, city: nil, number_of_guests: nil, responded: nil, sent: nil, state: nil, zip: nil}

  def fixture(:invitation) do
    {:ok, invitation} = Wedding.create_invitation(@create_attrs)
    invitation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, invitation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates invitation and renders invitation when data is valid", %{conn: conn} do
    conn = post conn, invitation_path(conn, :create), invitation: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, invitation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "address_one" => "some address_one",
      "address_two" => "some address_two",
      "city" => "some city",
      "number_of_guests" => 42,
      "responded" => true,
      "sent" => true,
      "state" => "some state",
      "zip" => "some zip"}
  end

  test "does not create invitation and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, invitation_path(conn, :create), invitation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen invitation and renders invitation when data is valid", %{conn: conn} do
    %Invitation{id: id} = invitation = fixture(:invitation)
    conn = put conn, invitation_path(conn, :update, invitation), invitation: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, invitation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "address_one" => "some updated address_one",
      "address_two" => "some updated address_two",
      "city" => "some updated city",
      "number_of_guests" => 43,
      "responded" => false,
      "sent" => false,
      "state" => "some updated state",
      "zip" => "some updated zip"}
  end

  test "does not update chosen invitation and renders errors when data is invalid", %{conn: conn} do
    invitation = fixture(:invitation)
    conn = put conn, invitation_path(conn, :update, invitation), invitation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen invitation", %{conn: conn} do
    invitation = fixture(:invitation)
    conn = delete conn, invitation_path(conn, :delete, invitation)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, invitation_path(conn, :show, invitation)
    end
  end
end
