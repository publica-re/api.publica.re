defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :uid, :string
    field :title, :string
    field :displayName, :string
    field :givenName, :string
    field :surname, :string
    field :initials, :string
    field :description, :string
    field :labeledURI, :string
    field :mail, :string
    field :jpegPhoto, :binary
    field :photo, :string
    field :preferredLanguage, :string
    field :mobile, :string
    field :telephoneNumber, :string
    field :businessCategory, :string
    field :employeeNumber, :string
    field :employeeType, :string
    field :organizationName, :string
    field :userCertificate, {:array, :string}
    field :postalAddress, :string
    field :postOfficeBox, :string
    field :postalCode, :string
    field :localityName, :string
    field :preferredDeliveryMethod, :string
    field :stateOrProvinceName, :string
    field :seeAlso, :string
    field :userPassword, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :uid,
      :title,
      :displayName,
      :givenName,
      :surname,
      :initials,
      :description,
      :labeledURI,
      :mail,
      :photo,
      :preferredLanguage,
      :mobile,
      :telephoneNumber,
      :businessCategory,
      :employeeNumber,
      :employeeType,
      :organizationName,
      :userCertificate,
      :postalAddress,
      :postOfficeBox,
      :postalCode,
      :localityName,
      :preferredDeliveryMethod,
      :stateOrProvinceName,
      :seeAlso
    ])
    |> validate_required([
      :uid
    ])
    |> unique_constraint(:uid)
  end

  def login_changeset do
    %__MODULE__{} |> cast(%{}, ~w(uid userPassword), ~w())
  end
end
