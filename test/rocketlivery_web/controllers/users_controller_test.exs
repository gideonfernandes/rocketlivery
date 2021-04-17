defmodule RocketliveryWeb.UsersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Mox
  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Rocketlivery.ViaCep.ClientMock
  alias RocketliveryWeb.Auth.Guardian

  describe "create/2" do
    test "creates the user, when all params are valid", %{conn: conn} do
      params = build(:user_valid_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created successfully!",
               "user" => %{
                 "address" => "Rua das Bananeiras",
                 "age" => 22,
                 "cep" => "12345678",
                 "cpf" => "12345678900",
                 "email" => "gideon@gmail.com",
                 "id" => _id,
                 "name" => "Gideon Fernandes"
               }
             } = response
    end

    test "returns an error, when there are invalid params", %{conn: conn} do
      params = build(:user_invalid_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["must be greater than 17"],
          "cep" => ["should be 8 character(s)"],
          "cpf" => ["should be 11 character(s)"],
          "email" => ["has invalid format"],
          "name" => ["can't be blank"],
          "password" => ["should be at least 6 character(s)"],
          "password_confirmation" => ["does not match confirmation"]
        }
      }

      assert response === expected_response
    end
  end

  describe "index/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "returns an list of users when is called", %{conn: conn, user: user} do
      response =
        conn
        |> get(Routes.users_path(conn, :index, page: 5, per_page: 10))
        |> json_response(:ok)

      expected_response = [
        %{
          "user" => %{
            "address" => "Rua das Bananeiras",
            "age" => 22,
            "cep" => "12345678",
            "city" => "Araras",
            "cpf" => user.cpf,
            "email" => user.email,
            "id" => user.id,
            "name" => "Gideon Fernandes",
            "uf" => "SP",
            "orders" => []
          }
        }
      ]

      assert expected_response === response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "deletes the user, when there is an user with the given id", %{
      conn: conn,
      user: %User{id: user_id}
    } do
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, user_id))
        |> response(:no_content)

      assert response === ""
    end

    test "returns an error when does not exists an user with the id provided", %{
      conn: conn,
      user: %User{id: user_id}
    } do
      pattern_to_replace = String.at(user_id, 0) <> String.at(user_id, 1)
      id_with_new_pattern = String.replace(user_id, pattern_to_replace, "00")

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id_with_new_pattern))
        |> response(:not_found)
        |> Jason.decode!()

      expected_response = %{"message" => "User not found!"}

      assert response === expected_response
    end
  end

  describe "show/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "shows the user, when there is an user with the given id", %{conn: conn, user: user} do
      response =
        conn
        |> get(Routes.users_path(conn, :show, user.id))
        |> response(:ok)
        |> Jason.decode!()

      expected_response = %{
        "user" => %{
          "address" => "Rua das Bananeiras",
          "age" => 22,
          "cep" => "12345678",
          "city" => "Araras",
          "cpf" => user.cpf,
          "email" => user.email,
          "id" => user.id,
          "name" => "Gideon Fernandes",
          "orders" => [],
          "uf" => "SP"
        }
      }

      assert expected_response === response
    end

    test "returns an error when does not exists an user with the id provided", %{
      conn: conn,
      user: %User{id: user_id}
    } do
      pattern_to_replace = String.at(user_id, 0) <> String.at(user_id, 1)
      id_with_new_pattern = String.replace(user_id, pattern_to_replace, "00")

      response =
        conn
        |> get(Routes.users_path(conn, :show, id_with_new_pattern))
        |> response(:not_found)
        |> Jason.decode!()

      expected_response = %{"message" => "User not found!"}

      assert response === expected_response
    end
  end
end
