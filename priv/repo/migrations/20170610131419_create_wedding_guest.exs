defmodule SD.Repo.Migrations.CreateSD.Wedding.Guest do
  use Ecto.Migration

  def change do
    create table(:wedding_guests) do
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :email, :string
      add :food_choice, :string
      add :plus_one, :boolean, default: false, null: false
      add :gift, :string
      add :thank_you_sent, :boolean, default: false, null: false
      add :table, :string
      add :send_updates, :boolean, default: false, null: false
      add :verified, :boolean, default: false, null: false
      add :attending, :boolean, default: false, null: false
      add :number_of_guests, :integer
      add :rsvp_date, :date
      add :config, :map
      add :salutation, :string
      add :address_one, :string
      add :address_two, :string
      add :city, :string
      add :state, :string
      add :zip, :string

      timestamps()
    end

  end
end
