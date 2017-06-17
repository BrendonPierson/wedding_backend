defmodule SD.Repo.Migrations.InvitationName do
  use Ecto.Migration

  def change do
    alter table(:wedding_invitations) do
      add :name, :string
    end

  end
end
