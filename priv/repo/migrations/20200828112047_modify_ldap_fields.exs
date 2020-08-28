defmodule Api.Repo.Migrations.ModifyLdapFields do
  use Ecto.Migration

  def change do
    alter table("users") do
      add(:cn, :string)

      remove(:businessCategory, :string, default: nil)
      remove(:employeeNumber, :string, default: nil)
      remove(:employeeType, :string, default: nil)
      remove(:preferredDeliveryMethod, :string, default: nil)
    end

    rename(table("users"), :surname, to: :sn)
  end
end
