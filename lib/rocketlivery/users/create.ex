defmodule Rocketlivery.Users.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{Error, Repo, User}

  alias Rocketlivery.ViaCep.Client

  alias Tesla.Env

  def call(%{"cep" => cep} = params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %{"localidade" => city, "uf" => uf} = cep_info} <- Client.get_cep_info(cep),
         {:ok, merged_changeset} <- merge_city_and_uf(city, uf, params),
         {:ok, %User{} = user} <- Repo.insert(merged_changeset) do
         {:ok, Repo.preload(user, :orders)}
    else
      {:error, %Error{}} = error -> error
      {:error, %Changeset{} = changeset} -> {:error, Error.build(:bad_request, changeset)}
      {:ok, %{"erro" => true}} -> {:error, Error.build(:not_found, "CEP not found!")}
    end
  end

  defp merge_city_and_uf(city, uf, params) do
    merged_params = Map.merge(%{"city" => city, "uf" => uf}, params)

    {:ok, User.changeset(merged_params)}
  end
end
