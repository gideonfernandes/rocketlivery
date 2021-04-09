defmodule Rocketlivery.ViaCep.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  alias Rocketlivery.Error
  alias Tesla.Env

  def get_cep_info(cep) do
    with {:ok, %Env{status: 200, body: body}} <- get("#{cep}/json") do
      {:ok, body}
    else
      {:ok, %Env{status: 400, body: _body}} -> {:error, Error.build(:bad_request, "Invalid CEP!")}
      {:error, reason} -> {:error, Error.build(:bad_request, reason)}
    end
  end
end
