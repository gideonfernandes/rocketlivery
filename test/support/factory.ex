defmodule Rocketlivery.Factory do
  use ExMachina.Ecto, repo: Rocketlivery.Repo

  alias Rocketlivery.User

  def user_factory do
    %User{
      address: "Rua das Bananeiras",
      age: 22,
      cep: "12345678",
      cpf: "12345678900",
      email: "gideon@gmail.com",
      name: "Gideon Fernandes",
      password: "123456",
      uf: "SP",
      city: "Araras"
    }
  end

  def user_valid_params_factory do
    %{
      "address" => "Rua das Bananeiras",
      "age" => 22,
      "cep" => "12345678",
      "cpf" => "12345678900",
      "email" => "gideon@gmail.com",
      "name" => "Gideon Fernandes",
      "password" => "123456",
      "password_confirmation" => "123456"
    }
  end

  def user_invalid_params_factory do
    %{
      "age" => 17,
      "cep" => "1234567",
      "cpf" => "1234567890",
      "email" => "gideon_gmail.com",
      "password" => "123",
      "password_confirmation" => "12"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
