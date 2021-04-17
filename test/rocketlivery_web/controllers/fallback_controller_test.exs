defmodule RocketliveryWeb.FallbackControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.{Error, User}
  alias RocketliveryWeb.{ErrorView, FallbackController}

  describe("call/2") do
    test "returns an error message when is called", %{conn: conn} do
      response =
        FallbackController.call(
          conn,
          {:error, %Error{status: :bad_request, result: "Some error message!"}}
        )

      assert %Plug.Conn{
               private: %{
                 phoenix_template: "error.json",
                 phoenix_view: ErrorView
               },
               resp_body: "{\"message\":\"Some error message!\"}",
               status: 400
             } = response
    end

    test "returns some changeset error messages when an invalid changeset is provided", %{
      conn: conn
    } do
      changeset =
        build(:user_invalid_params)
        |> User.changeset()

      response =
        FallbackController.call(
          conn,
          {:error, %Error{status: :bad_request, result: changeset}}
        )

      assert %Plug.Conn{
               private: %{
                 phoenix_recycled: true,
                 phoenix_template: "error.json",
                 phoenix_view: RocketliveryWeb.ErrorView,
                 plug_skip_csrf_protection: true
               },
               resp_body:
                 "{\"message\":{\"address\":[\"can't be blank\"],\"age\":[\"must be greater than 17\"],\"cep\":[\"should be 8 character(s)\"],\"cpf\":[\"should be 11 character(s)\"],\"email\":[\"has invalid format\"],\"name\":[\"can't be blank\"],\"password\":[\"should be at least 6 character(s)\"],\"password_confirmation\":[\"does not match confirmation\"]}}",
               status: 400
             } = response
    end
  end
end
