defmodule Rocketlivery.ViaCep.Client do
  use Tesla

  @behaviour Rocketlivery.ViaCep.Behaviour
  @base_url "https://viacep.com.br/ws/"

  plug Tesla.Middleware.JSON

  alias Rocketlivery.Error
  alias Tesla.Env

  def get_cep_info(url \\ @base_url, cep) do
    case get("#{url}#{cep}/json") do
      {:ok, %Env{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %Env{status: 400, body: _body}} ->
        {:error, Error.build(:bad_request, "Invalid CEP!")}

      {:error,
       {Tesla.Middleware.JSON, :decode, %Jason.DecodeError{data: "{:ok, {\"erro\": true}}"}}} ->
        {:error, Error.build(:not_found, "CEP not found!")}

      {:error, reason} ->
        {:error, Error.build(:bad_request, reason)}
    end
  end
end
