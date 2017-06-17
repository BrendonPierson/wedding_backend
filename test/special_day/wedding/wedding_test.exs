defmodule SD.WeddingTest do
  use SD.DataCase

  alias SD.Wedding

  describe "guests" do
    alias SD.Wedding.Guest

    @valid_attrs %{attending: true, config: %{}, email: "some email", first_name: "some first_name", food_choice: "some food_choice", gift: "some gift", last_name: "some last_name", number_of_guests: 42, phone: "some phone", plus_one: true, rsvp_date: ~D[2010-04-17], send_updates: true, table: "some table", thank_you_sent: true, verified: true}
    @update_attrs %{attending: false, config: %{}, email: "some updated email", first_name: "some updated first_name", food_choice: "some updated food_choice", gift: "some updated gift", last_name: "some updated last_name", number_of_guests: 43, phone: "some updated phone", plus_one: false, rsvp_date: ~D[2011-05-18], send_updates: false, table: "some updated table", thank_you_sent: false, verified: false}
    @invalid_attrs %{attending: nil, config: nil, email: nil, first_name: nil, food_choice: nil, gift: nil, last_name: nil, number_of_guests: nil, phone: nil, plus_one: nil, rsvp_date: nil, send_updates: nil, table: nil, thank_you_sent: nil, verified: nil}

    def guest_fixture(attrs \\ %{}) do
      {:ok, guest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wedding.create_guest()

      guest
    end

    test "list_guests/0 returns all guests" do
      guest = guest_fixture()
      assert Wedding.list_guests() == [guest]
    end

    test "get_guest!/1 returns the guest with given id" do
      guest = guest_fixture()
      assert Wedding.get_guest!(guest.id) == guest
    end

    test "create_guest/1 with valid data creates a guest" do
      assert {:ok, %Guest{} = guest} = Wedding.create_guest(@valid_attrs)
      assert guest.attending == true
      assert guest.config == %{}
      assert guest.email == "some email"
      assert guest.first_name == "some first_name"
      assert guest.food_choice == "some food_choice"
      assert guest.gift == "some gift"
      assert guest.last_name == "some last_name"
      assert guest.number_of_guests == 42
      assert guest.phone == "some phone"
      assert guest.plus_one == true
      assert guest.rsvp_date == ~D[2010-04-17]
      assert guest.send_updates == true
      assert guest.table == "some table"
      assert guest.thank_you_sent == true
      assert guest.verified == true
    end

    test "create_guest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wedding.create_guest(@invalid_attrs)
    end

    test "update_guest/2 with valid data updates the guest" do
      guest = guest_fixture()
      assert {:ok, guest} = Wedding.update_guest(guest, @update_attrs)
      assert %Guest{} = guest
      assert guest.attending == false
      assert guest.config == %{}
      assert guest.email == "some updated email"
      assert guest.first_name == "some updated first_name"
      assert guest.food_choice == "some updated food_choice"
      assert guest.gift == "some updated gift"
      assert guest.last_name == "some updated last_name"
      assert guest.number_of_guests == 43
      assert guest.phone == "some updated phone"
      assert guest.plus_one == false
      assert guest.rsvp_date == ~D[2011-05-18]
      assert guest.send_updates == false
      assert guest.table == "some updated table"
      assert guest.thank_you_sent == false
      assert guest.verified == false
    end

    test "update_guest/2 with invalid data returns error changeset" do
      guest = guest_fixture()
      assert {:error, %Ecto.Changeset{}} = Wedding.update_guest(guest, @invalid_attrs)
      assert guest == Wedding.get_guest!(guest.id)
    end

    test "delete_guest/1 deletes the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{}} = Wedding.delete_guest(guest)
      assert_raise Ecto.NoResultsError, fn -> Wedding.get_guest!(guest.id) end
    end

    test "change_guest/1 returns a guest changeset" do
      guest = guest_fixture()
      assert %Ecto.Changeset{} = Wedding.change_guest(guest)
    end
  end

  describe "invitations" do
    alias SD.Wedding.Invitation

    @valid_attrs %{address_one: "some address_one", address_two: "some address_two", city: "some city", number_of_guests: 42, responded: true, sent: true, state: "some state", zip: "some zip"}
    @update_attrs %{address_one: "some updated address_one", address_two: "some updated address_two", city: "some updated city", number_of_guests: 43, responded: false, sent: false, state: "some updated state", zip: "some updated zip"}
    @invalid_attrs %{address_one: nil, address_two: nil, city: nil, number_of_guests: nil, responded: nil, sent: nil, state: nil, zip: nil}

    def invitation_fixture(attrs \\ %{}) do
      {:ok, invitation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wedding.create_invitation()

      invitation
    end

    test "list_invitations/0 returns all invitations" do
      invitation = invitation_fixture()
      assert Wedding.list_invitations() == [invitation]
    end

    test "get_invitation!/1 returns the invitation with given id" do
      invitation = invitation_fixture()
      assert Wedding.get_invitation!(invitation.id) == invitation
    end

    test "create_invitation/1 with valid data creates a invitation" do
      assert {:ok, %Invitation{} = invitation} = Wedding.create_invitation(@valid_attrs)
      assert invitation.address_one == "some address_one"
      assert invitation.address_two == "some address_two"
      assert invitation.city == "some city"
      assert invitation.number_of_guests == 42
      assert invitation.responded == true
      assert invitation.sent == true
      assert invitation.state == "some state"
      assert invitation.zip == "some zip"
    end

    test "create_invitation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wedding.create_invitation(@invalid_attrs)
    end

    test "update_invitation/2 with valid data updates the invitation" do
      invitation = invitation_fixture()
      assert {:ok, invitation} = Wedding.update_invitation(invitation, @update_attrs)
      assert %Invitation{} = invitation
      assert invitation.address_one == "some updated address_one"
      assert invitation.address_two == "some updated address_two"
      assert invitation.city == "some updated city"
      assert invitation.number_of_guests == 43
      assert invitation.responded == false
      assert invitation.sent == false
      assert invitation.state == "some updated state"
      assert invitation.zip == "some updated zip"
    end

    test "update_invitation/2 with invalid data returns error changeset" do
      invitation = invitation_fixture()
      assert {:error, %Ecto.Changeset{}} = Wedding.update_invitation(invitation, @invalid_attrs)
      assert invitation == Wedding.get_invitation!(invitation.id)
    end

    test "delete_invitation/1 deletes the invitation" do
      invitation = invitation_fixture()
      assert {:ok, %Invitation{}} = Wedding.delete_invitation(invitation)
      assert_raise Ecto.NoResultsError, fn -> Wedding.get_invitation!(invitation.id) end
    end

    test "change_invitation/1 returns a invitation changeset" do
      invitation = invitation_fixture()
      assert %Ecto.Changeset{} = Wedding.change_invitation(invitation)
    end
  end
end
