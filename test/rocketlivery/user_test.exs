defmodule Rocketlivery.UserTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.User

  describe "changeset/1" do
    test "returns a valid changeset, when all params are valid" do
      params = build(:user_valid_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Gideon Fernandes", age: 22}, valid?: true} = response
    end

    test "returns an invalid changeset when there are some error" do
      params = build(:user_invalid_params)

      response = User.changeset(params)

      expected_response = %{
        address: ["can't be blank"],
        age: ["must be greater than 17"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        name: ["can't be blank"],
        password: ["should be at least 6 character(s)"],
        password_confirmation: ["does not match confirmation"]
      }

      assert errors_on(response) === expected_response
    end
  end

  describe "changeset/2" do
    test "returns a valid changeset with the given changes, when updating a changeset" do
      params = build(:user_valid_params)

      updated_params = %{name: "Fernandes Gideon"}

      response =
        params
        |> User.changeset()
        |> User.changeset(updated_params)

      assert %Changeset{changes: %{name: "Fernandes Gideon"}, valid?: true} = response
    end

    test "returns an invalid changeset when there are some error updating a changeset" do
      params = build(:user_valid_params)

      updated_params = %{age: 17, email: "gideon_fernandes"}

      response =
        params
        |> User.changeset()
        |> User.changeset(updated_params)

      expected_response = %{
        age: ["must be greater than 17"],
        email: ["has invalid format"]
      }

      assert errors_on(response) === expected_response
    end
  end
end
