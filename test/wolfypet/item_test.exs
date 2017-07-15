defmodule Wolfypet.ItemTest do
	alias Wolfypet.{Item,Repo}
  use ExUnit.Case
	doctest Wolfypet.Item

	setup do
		:ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
	end

	test "adding and retrieving items from database" do
		assert [] = Item.all
		Item.add("Item 1")
		Item.add("Item 2")

		items = Item.all

		assert length(items) == 2
		assert ["Item 1", "Item 2"] == items
	end

	test "preventing duplicate items during add" do
		assert [] = Item.all
		Item.add("Item")
		assert {:error, reason} = Item.add("Item")
		assert reason.errors == [what: {"has already been taken",[]}]
	end
end
