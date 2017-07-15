defmodule Wolfypet.Fact do
  use Ecto.Schema
  alias Wolfypet.{Repo, Fact}
  import Ecto.Query

  schema "facts" do
    field :fact, :string
    field :tidbit, :string
    field :verb, :string, default: "is"
    field :protected, :boolean, default: false
    timestamps()
  end

  def changeset(fact, params \\ %{}) do
    fact
    |> Ecto.Changeset.cast(params, [:fact, :tidbit, :verb, :protected])
    |> Ecto.Changeset.validate_required([:fact, :tidbit])
  end

  def full_facts do
    (from f in Fact, select: {f.fact, f.verb, f.tidbit})
    |> Repo.all
  end

  def add(fact, verb, tidbit) do
    Fact.changeset(%Fact{}, %{fact: fact, verb: verb, tidbit: tidbit})
    |> Ecto.Changeset.unique_constraint(:fact, [name: :unique_factoid])
    |> Repo.insert
  end
end
