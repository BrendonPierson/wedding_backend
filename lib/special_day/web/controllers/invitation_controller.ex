defmodule SD.Web.InvitationController do
  # use SD.Web, :controller
  #
  # alias SD.Wedding
  # alias SD.Wedding.Invitation
  #
  # action_fallback SD.Web.FallbackController
  #
  # def index(conn, _params) do
  #   invitations = Wedding.list_invitations()
  #   render(conn, "index.json", invitations: invitations)
  # end
  #
  # def create(conn, %{"invitation" => invitation_params}) do
  #   with {:ok, %Invitation{} = invitation} <- Wedding.create_invitation(invitation_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", invitation_path(conn, :show, invitation))
  #     |> render("show.json", invitation: invitation)
  #   end
  # end
  #
  # def show(conn, %{"id" => id}) do
  #   invitation = Wedding.get_invitation!(id)
  #   render(conn, "show.json", invitation: invitation)
  # end
  #
  # def update(conn, %{"id" => id, "invitation" => invitation_params}) do
  #   invitation = Wedding.get_invitation!(id)
  #
  #   with {:ok, %Invitation{} = invitation} <- Wedding.update_invitation(invitation, invitation_params) do
  #     render(conn, "show.json", invitation: invitation)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   invitation = Wedding.get_invitation!(id)
  #   with {:ok, %Invitation{}} <- Wedding.delete_invitation(invitation) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
