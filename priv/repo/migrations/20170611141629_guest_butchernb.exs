defmodule SD.Repo.Migrations.GuestButchernb do
  use Ecto.Migration

  def change do
    alter table(:wedding_guests) do
      add :attending_butcher_and_bee, :string
    end

  end
end
