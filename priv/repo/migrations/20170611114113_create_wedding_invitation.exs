defmodule SD.Repo.Migrations.CreateSD.Wedding.Invitation do
  use Ecto.Migration

  def change do
    create table(:wedding_invitations) do
      add :address_one, :string
      add :address_two, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :sent, :boolean, default: false, null: false
      add :responded, :boolean, default: false, null: false
      add :number_of_guests, :integer

      timestamps()
    end

  end
end
