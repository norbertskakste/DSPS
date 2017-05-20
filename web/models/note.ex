defmodule Dsps.Note do
  use Dsps.Web, :model
  alias Dsps.Repo
  alias Dsps.User

  import Ecto.Query, only: [from: 2]

    schema "notes" do
        field :title, :string
        field :body, :string

        belongs_to :user, Dsps.User, foreign_key: :user_id
        timestamps()
    end


  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
    |> foreign_key_constraint(:users, name: :user_id)
  end

  def get_all_by_user(user_id) do
    query = from u in Dsps.Note,
            where: u.user_id == ^user_id

    case notes = Repo.all(query) do
    nil ->
        nil
    _ ->
        notes = Enum.map(notes, fn (x) ->
            user = Repo.get(User, x.user_id)
            Map.put(x, :user, user)
        end)
      end
    end

  def get_all_by_user(user_id, :frontpage) do
    query = from u in Dsps.Note,
            where: u.user_id == ^user_id,
            order_by: [desc: :id], limit: 3

    case notes = Repo.all(query) do
        nil ->
            nil
        _ ->
            notes = Enum.map(notes, fn (x) ->
                user = Repo.get(User, x.user_id)
                Map.put(x, :user, user)
            end)
    end
  end
end
