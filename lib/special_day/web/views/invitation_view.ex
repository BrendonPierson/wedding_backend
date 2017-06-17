defmodule SD.Web.InvitationView do
  use SD.Web, :view
  alias SD.Web.InvitationView

  def render("index.json", %{invitations: invitations}) do
    %{data: render_many(invitations, InvitationView, "invitation.json")}
  end

  def render("show.json", %{invitation: invitation}) do
    %{data: render_one(invitation, InvitationView, "invitation.json")}
  end

  def render("invitation.json", %{invitation: invitation}) do
    %{id: invitation.id,
      address_one: invitation.address_one,
      address_two: invitation.address_two,
      city: invitation.city,
      state: invitation.state,
      name: invitation.name,
      zip: invitation.zip,
      sent: invitation.sent,
      responded: invitation.responded,
      number_of_guests: invitation.number_of_guests}
  end
end
