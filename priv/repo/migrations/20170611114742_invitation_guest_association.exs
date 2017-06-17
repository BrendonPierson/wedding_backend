defmodule SD.Repo.Migrations.InvitationGuestAssociation do
  use Ecto.Migration

  def change do
    alter table(:wedding_guests) do
      add :invitation_id, references(:wedding_invitations)
    end
  end
end
