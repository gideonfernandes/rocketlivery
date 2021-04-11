defmodule Rocketlivery.Users.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{Error, Repo, User}

  def call(params) do
    cep = Map.get(params, "cep")
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %{"localidade" => city, "uf" => uf}} <- client().get_cep_info(cep),
         {:ok, merged_changeset} <- merge_city_and_uf(city, uf, params),
         {:ok, %User{} = user} <- Repo.insert(merged_changeset) do
      {:ok, Repo.preload(user, :orders)}
    else
      {:error, %Error{}} = error ->
        error

      {:error, %Changeset{} = changeset} ->
        {:error, Error.build(:bad_request, changeset)}

      {:ok, %{"erro" => true}} ->
        {:error, Error.build(:not_found, "CEP not found!")}
    end
  end

  defp client do
    :rocketlivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end

  defp merge_city_and_uf(city, uf, params) do
    merged_params = Map.merge(%{"city" => city, "uf" => uf}, params)

    {:ok, User.changeset(merged_params)}
  end
end
