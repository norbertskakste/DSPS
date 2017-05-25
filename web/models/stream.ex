defmodule Dsps.Stream do
    use Dsps.Web, :model
    use Rummage.Ecto
    import Ecto

    schema "streams" do
        field :name, :string
        field :description, :string
        field :realtime, :boolean
        field :enabled, :boolean
        field :finalized, :boolean
        field :uuid, :string

        timestamps()

        has_many :stream_variables, Dsps.StreamVariable, on_delete: :delete_all
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:name, :description, :realtime, :enabled, :finalized])
        |> validate_required([:name, :description])
        |> unique_constraint(:name, message: "Stream Name already taken")
    end

    def finalize(stream, repo) do
        stream = Ecto.Changeset.change stream, finalized: true

        repo.update(Dsps.Stream, stream)
    end
end
