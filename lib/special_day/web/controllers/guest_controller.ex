defmodule SD.Web.GuestController do
  use SD.Web, :controller

  alias SD.Wedding
  alias SD.Wedding.Guest

  action_fallback SD.Web.FallbackController

  @doc """
  No invite id found, good code, or bad code paths
  """
  def rsvp(conn, %{"code" => "11182017" <> ""}) do
  end
  def rsvp(conn, %{"code" => "11182017" <> code}) do
    with %{invite: invite, guests: guests } <- Wedding.check_code(code) do
      render(conn, "invite_guests.json", guests: guests, invite: invite)
    else
      _ -> {:error, :invalid_code}
    end
  end
  def rsvp(conn, _), do: {:error, :invalid_code}

  def save(conn, %{"guests" => guests, "invite" => %{"id" => invite_id}}) do
    with _guests <- Wedding.save_guests(guests),
      {:ok, invite} <- Wedding.invite_replied(invite_id)
    do
      json(conn, %{success: true})
      # render(conn, "invite_guests.json", guests: guests, invite: invite)
    end
  end

  def index(conn, _params) do
    guests = Wedding.list_guests()
    render(conn, "index.json", guests: guests)
  end

  def create(conn, %{"guest" => guest_params}) do
    with {:ok, %Guest{} = guest} <- Wedding.create_guest(guest_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", guest_path(conn, :show, guest))
      |> render("show.json", guest: guest)
    end
  end

  def show(conn, %{"id" => id}) do
    guest = Wedding.get_guest!(id)
    render(conn, "show.json", guest: guest)
  end

  def update(conn, %{"id" => id, "guest" => guest_params}) do
    guest = Wedding.get_guest!(id)

    with {:ok, %Guest{} = guest} <- Wedding.update_guest(guest, guest_params) do
      render(conn, "show.json", guest: guest)
    end
  end

  def delete(conn, %{"id" => id}) do
    guest = Wedding.get_guest!(id)
    with {:ok, %Guest{}} <- Wedding.delete_guest(guest) do
      send_resp(conn, :no_content, "")
    end
  end
end
