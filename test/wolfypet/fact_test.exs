defmodule Wolfypet.FactTest do
  alias Wolfypet.{Fact,Repo}
  use ExUnit.Case
  doctest Wolfypet.Fact

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "adding and retrieving factoids" do
    assert [] = Fact.full_facts
    Fact.add("A factoid", "is", "a factoid")
    Fact.add("A factoid", "is", "life")
    assert length(Fact.full_facts) == 2
  end

  test "preventing duplicate factoids when adding" do
    assert [] = Fact.full_facts
    Fact.add("Cow", "is", "moo")
    assert {:error, _reason} = Fact.add("Cow", "is", "moo")
  end
end
