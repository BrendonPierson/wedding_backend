defmodule SD.Wedding.Invitation do
  use Ecto.Schema
  import Ecto.Changeset
  alias SD.Wedding.{Invitation, Guest}


  schema "wedding_invitations" do
    field :address_one, :string
    field :address_two, :string
    field :city, :string
    field :number_of_guests, :integer
    field :responded, :boolean, default: false
    field :sent, :boolean, default: false
    field :state, :string
    field :zip, :string
    field :name, :string
    has_many :guests, Guest

    timestamps()
  end

  @doc false
  def changeset(%Invitation{} = invitation, attrs) do
    invitation
    |> cast(attrs, [:address_one, :address_two, :city, :state, :zip, :sent, :responded, :number_of_guests])
    |> validate_required([:address_one, :city, :state, :zip, :sent, :responded])
  end
end
