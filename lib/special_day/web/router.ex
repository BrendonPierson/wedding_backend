defmodule SD.Web.Router do
  use SD.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SD.Web do
    pipe_through :api
    get "/rsvp", GuestController, :rsvp
    post "/rsvp", GuestController, :save
    resources "/guests", GuestController, except: [:new, :edit]
    resources "/invitations", InvitationController, except: [:new, :edit]
  end
end
