defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Mox
  import Rocketlivery.Factory

  alias Rocketlivery.{Error, User}
  alias Rocketlivery.Users.Create
  alias Rocketlivery.ViaCep.ClientMock

  describe "call/1" do
    test "returns the user, when all params are valids" do
      params = build(:user_valid_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 22, email: "gideon@gmail.com"}} = response
    end

    test "returns an error, when there are invalid params" do
      params = build(:user_invalid_params)

      response = Create.call(params)

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

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
