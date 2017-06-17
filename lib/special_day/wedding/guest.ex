defmodule SD.Wedding.Guest do
  use Ecto.Schema
  import Ecto.Changeset
  alias SD.Wedding.{Guest, Invitation}


  schema "wedding_guests" do
    field :attending, :boolean, default: false
    field :config, :map
    field :email, :string
    field :first_name, :string
    field :food_choice, :string
    field :gift, :string
    field :last_name, :string
    field :number_of_guests, :integer
    field :phone, :string
    field :plus_one, :boolean, default: false
    field :rsvp_date, :date
    field :send_updates, :boolean, default: false
    field :table, :string
    field :thank_you_sent, :boolean, default: false
    field :verified, :boolean, default: false
    field :salutation, :string
    field :address_one, :string
    field :address_two, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :attending_butcher_and_bee, :boolean
    belongs_to :invitation, Invitation

    timestamps()
  end

  @doc false
  def changeset(%Guest{} = guest, attrs) do
    guest
    |> cast(attrs, [:attending_butcher_and_bee, :first_name, :last_name, :phone, :email, :food_choice, :plus_one, :gift, :thank_you_sent, :table, :send_updates, :verified, :attending, :number_of_guests, :rsvp_date, :config, :salutation, :address_one, :address_two, :city, :state, :zip])
    # |> validate_required([:first_name, :last_name, :phone, :email, :food_choice, :plus_one, :gift, :thank_you_sent, :table, :send_updates, :verified, :attending, :number_of_guests, :rsvp_date, :config, :salutation, :address_one, :address_two, :city, :state, :zip])
  end
end
