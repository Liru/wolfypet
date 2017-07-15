defmodule Wolfypet.Item do
  use Ecto.Schema
  alias Wolfypet.{Repo, Item}
  import Ecto.Query

  schema "items" do
    field :channel, :string
		field :what, :string
		field :user, :string
  end

  def changeset(item, params \\ %{}) do
    item
    |> Ecto.Changeset.cast(params, [:channel, :what, :user])
    |> Ecto.Changeset.validate_required([:what])
		|> Ecto.Changeset.validate_length(:what, min: 2)
  end

	@doc """
	Returns all items ever added to the database, in list form.
	"""
	@spec all :: [String.t]
	def all do
		(from i in Item, select: i.what)
		|> Repo.all
	end

	@doc """
	Adds an item to the database.

	Ignores the result if it's already there. We don't care.
	"""
  def add(%{item: item, channel: channel, user: user}) do
		Item.changeset(%Item{}, # FIXME: Holy balls this is ugly code.
			%{item: item, channel: channel, user: user})
    |> Ecto.Changeset.unique_constraint(:item)
    |> Repo.insert
  end

	# The solo-string version of the above.
  def add(item) when is_bitstring(item) do
		Item.changeset(%Item{}, %{what: item})
    |> Ecto.Changeset.unique_constraint(:what)
    |> Repo.insert
  end
end

