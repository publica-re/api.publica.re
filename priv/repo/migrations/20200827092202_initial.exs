defmodule Api.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table("users") do
      add :uid, :string
      add :title, :string
      add :displayName, :string
      add :givenName, :string
      add :surname, :string
      add :initials, :string
      add :description, :string
      add :labeledURI, :string
      add :mail, :string
      add :jpegPhoto, :binary
      add :photo, :string
      add :preferredLanguage, :string
      add :mobile, :string
      add :telephoneNumber, :string
      add :businessCategory, :string
      add :employeeNumber, :string
      add :employeeType, :string
      add :organizationName, :string
      add :userCertificate, {:array, :string}
      add :postalAddress, :string
      add :postOfficeBox, :string
      add :postalCode, :string
      add :localityName, :string
      add :preferredDeliveryMethod, :string
      add :stateOrProvinceName, :string
      add :seeAlso, :string

      timestamps()
    end

    create unique_index(:users, [:uid])
  end

  def down do
    drop table("users")
  end
end
