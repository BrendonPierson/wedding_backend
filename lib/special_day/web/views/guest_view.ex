defmodule SD.Web.GuestView do
  use SD.Web, :view
  alias SD.Web.{GuestView, InvitationView}

  def render("index.json", %{guests: guests}) do
    %{data: render_many(guests, GuestView, "guest.json")}
  end

  def render("show.json", %{guest: guest}) do
    %{data: render_one(guest, GuestView, "guest.json")}
  end

  def render("invite_guests.json", %{invite: invite, guests: guests}) do
    %{data: %{
      guests: render_many(guests, GuestView, "guest.json"),
      invite: render_one(invite, InvitationView, "invitation.json")
    }}
  end

  def render("guest.json", %{guest: guest}) do
    %{id: guest.id,
      firstName: guest.first_name,
      lastName: guest.last_name,
      phone: guest.phone,
      email: guest.email,
      foodChoice: guest.food_choice,
      plusOne: guest.plus_one,
      gift: guest.gift,
      thankYouSent: guest.thank_you_sent,
      table: guest.table,
      sendUpdates: guest.send_updates,
      verified: guest.verified,
      attending: guest.attending,
      attendingButcherAndBee: guest.attending_butcher_and_bee,
      numberOfGuests: guest.number_of_guests,
      rsvpDate: guest.rsvp_date,
      salutation: guest.salutation,
      addressOne: guest.address_one,
      addressTwo: guest.address_two,
      city: guest.city,
      state: guest.state,
      zip: guest.zip,
      config: guest.config}
  end

  def render("bad_rsvp_code.json",_) do
    %{error: "Invalid RSVP code."}
  end
end
