defmodule SD.Wedding do
  @moduledoc """
  The boundary for the Wedding system.
  """

  import Ecto.Query, warn: false
  alias SD.Repo

  alias SD.Wedding.{Guest, Invitation}

  @doc """
  Check if an rsvp code is valid
  """
  def check_code(code) do
    case get_invitation(code) do
      nil -> false
      %Invitation{id: id} = invite -> %{
        invite: invite,
        guests: get_guests_for_invite(id)
      }
    end
  end

  def get_guests_for_invite(id) do
    Guest
    |> where(invitation_id: ^id)
    |> select([g], g)
    |> Repo.all
  end

  def invite_replied(id) do
    id
    |> get_invitation
    |> Invitation.changeset(%{responded: true})
    |> Repo.update
  end

  def save_guests(guests) do
    guests
    |> Enum.map(&save_guest/1)
    |> Enum.map(fn({:ok, g}) -> g end)
  end

  def save_guest(%{
    "id" => id,
    "attending" => attending,
    "attendingButcherAndBee" => attending_bb,
    "foodChoice" => food_choice,
    "firstName" => first_name,
    "lastName" => last_name,
  }) do
  id
  |> get_guest
  |> Guest.changeset(%{
      attending: attending,
      attending_butcher_and_bee: attending_bb,
      food_choice: food_choice,
      first_name: first_name,
      last_name: last_name,
    })
  |> Repo.update
  end

  @doc """
  Returns the list of guests.

  ## Examples

      iex> list_guests()
      [%Guest{}, ...]

  """
  def list_guests do
    Repo.all(Guest)
  end

  @doc """
  Gets a single guest.

  Raises `Ecto.NoResultsError` if the Guest does not exist.

  ## Examples

      iex> get_guest!(123)
      %Guest{}

      iex> get_guest!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guest!(id), do: Repo.get!(Guest, id)
  def get_guest(id) when is_binary(id), do: get_guest(String.to_integer(id))
  def get_guest(id), do: Repo.get(Guest, id)

  @doc """
  Creates a guest.

  ## Examples

      iex> create_guest(%{field: value})
      {:ok, %Guest{}}

      iex> create_guest(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guest(attrs \\ %{}) do
    %Guest{}
    |> Guest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guest.

  ## Examples

      iex> update_guest(guest, %{field: new_value})
      {:ok, %Guest{}}

      iex> update_guest(guest, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guest(%Guest{} = guest, attrs) do
    guest
    |> Guest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Guest.

  ## Examples

      iex> delete_guest(guest)
      {:ok, %Guest{}}

      iex> delete_guest(guest)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guest(%Guest{} = guest) do
    Repo.delete(guest)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guest changes.

  ## Examples

      iex> change_guest(guest)
      %Ecto.Changeset{source: %Guest{}}

  """
  def change_guest(%Guest{} = guest) do
    Guest.changeset(guest, %{})
  end

  alias SD.Wedding.Invitation

  @doc """
  Returns the list of invitations.

  ## Examples

      iex> list_invitations()
      [%Invitation{}, ...]

  """
  def list_invitations do
    Repo.all(Invitation)
  end

  @doc """
  Gets a single invitation.

  Raises `Ecto.NoResultsError` if the Invitation does not exist.

  ## Examples

      iex> get_invitation(123)
      %Invitation{}

      iex> get_invitation(456)
      ** (Ecto.NoResultsError)

  """
  def get_invitation(id) when is_binary(id) do
    get_invitation(String.to_integer(id))
  end
  def get_invitation(id), do: Repo.get(Invitation, id)

  @doc """
  Creates a invitation.

  ## Examples

      iex> create_invitation(%{field: value})
      {:ok, %Invitation{}}

      iex> create_invitation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invitation(attrs \\ %{}) do
    %Invitation{}
    |> Invitation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invitation.

  ## Examples

      iex> update_invitation(invitation, %{field: new_value})
      {:ok, %Invitation{}}

      iex> update_invitation(invitation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invitation(%Invitation{} = invitation, attrs) do
    invitation
    |> Invitation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Invitation.

  ## Examples

      iex> delete_invitation(invitation)
      {:ok, %Invitation{}}

      iex> delete_invitation(invitation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invitation(%Invitation{} = invitation) do
    Repo.delete(invitation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invitation changes.

  ## Examples

      iex> change_invitation(invitation)
      %Ecto.Changeset{source: %Invitation{}}

  """
  def change_invitation(%Invitation{} = invitation) do
    Invitation.changeset(invitation, %{})
  end
end
