defmodule Wolfypet.Repo.Migrations.CreateBasicTables do
  use Ecto.Migration

  def change do
    create table(:facts) do
      add :fact, :string
      add :tidbit, :string
      add :verb, :string, default: "is"
      add :protected, :boolean, default: false

      add :added_by, :string
      timestamps()
    end

    create unique_index(:facts, [:fact, :tidbit, :verb], name: :unique_factoid)

    create table(:items) do
      add :channel, :string
      add :what, :string
      add :user, :string
    end


    create unique_index(:items, [:what])

    create table(:vars) do
      add :name, :string
      add :editable, :boolean
      add :type, :string
    end

    create unique_index(:vars, [:name])

    create table(:values) do
      add :var_id, references(:vars)
      add :value, :string
    end

    create unique_index(:values, [:var_id, :value])

  end
end
