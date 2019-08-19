ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Rumbl.Repo, :manual)

defmodule Rumbl.TestHelpers do
  alias Rumbl.{Accounts, Multimedia}

  def user_fixtures(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "Some User",
        username: "user#{System.unique_integer([:positive])}",
        password: attrs[:password] || "supersecret"
      })
      |> Accounts.register_user()

    user
  end

  def video_fixtures(%Accounts.User{} = user, _attrs \\ %{}) do
    attrs =
      Enum.into(%{
        title: "A Title",
        url: "https://example.com",
        descrition: "A description"
      })

    {:ok, video} = Multimedia.create_video(user, attrs)

    video
  end
end
