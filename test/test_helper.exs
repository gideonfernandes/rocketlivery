ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Rocketlivery.Repo, :manual)

Mox.defmock(Rocketlivery.ViaCep.ClientMock, for: Rocketlivery.ViaCep.Behaviour)
