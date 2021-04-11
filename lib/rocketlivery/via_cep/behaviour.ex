defmodule Rocketlivery.ViaCep.Behaviour do
  alias Rocketlivery.Error
  @typep via_cep_response :: {:ok, map()} | {:error, %Error{}}

  @callback get_cep_info(String.t()) :: via_cep_response
  @callback get_cep_info(String.t(), String.t()) :: via_cep_response
end
