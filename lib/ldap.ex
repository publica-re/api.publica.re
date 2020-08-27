defmodule Api.Ldap do
  alias Api.Accounts.User

  @spec authenticate(binary | keyword, binary) ::
          :ok
          | {:error,
             :anonymous_auth
             | :authMethodNotSupported
             | :inappropriateAuthentication
             | :invalidCredentials
             | :operationsError
             | :protocolError
             | :referral
             | :saslBindInProgress
             | :strongAuthRequired
             | :unavailable}
  def authenticate(uid, password) do
    Paddle.authenticate(uid, password)
  end

  def get_by_uid(uid) do
    {:ok, [user]} = Paddle.get(filter: [uid: uid], base: [ou: "users"])

    to_map(user)
  end

  def list() do
    {:ok, users} = Paddle.get(filter: [objectClass: "inetOrgPerson"], base: [ou: "users"])
    Enum.map(users, fn x -> to_map(x) end)
  end

  defp get_value_from_list(entry, field) do
    List.first(entry[field] || [])
  end

  def to_map(entry) do
    %{
      uid: get_value_from_list(entry, "uid") || get_value_from_list(entry, "commonName"),
      title: get_value_from_list(entry, "title"),
      displayName: get_value_from_list(entry, "displayName"),
      givenName: get_value_from_list(entry, "givenName"),
      surname: get_value_from_list(entry, "surname"),
      initials: get_value_from_list(entry, "initials"),
      description: get_value_from_list(entry, "description"),
      labeledURI: get_value_from_list(entry, "labeledURI"),
      mail: get_value_from_list(entry, "mail"),
      jpegPhoto: get_value_from_list(entry, "jpegPhoto"),
      photo: get_value_from_list(entry, "photo"),
      preferredLanguage: get_value_from_list(entry, "preferredLanguage"),
      mobile: get_value_from_list(entry, "mobile"),
      telephoneNumber: get_value_from_list(entry, "telephoneNumber"),
      businessCategory: get_value_from_list(entry, "businessCategory"),
      employeeNumber: get_value_from_list(entry, "employeeNumber"),
      employeeType: get_value_from_list(entry, "employeeType"),
      organizationName: get_value_from_list(entry, "organizationName"),
      userCertificate: get_value_from_list(entry, "array"),
      postalAddress: get_value_from_list(entry, "postalAddress"),
      postOfficeBox: get_value_from_list(entry, "postOfficeBox"),
      postalCode: get_value_from_list(entry, "postalCode"),
      localityName: get_value_from_list(entry, "localityName"),
      preferredDeliveryMethod: get_value_from_list(entry, "preferredDeliveryMethod"),
      stateOrProvinceName: get_value_from_list(entry, "stateOrProvinceName"),
      seeAlso: get_value_from_list(entry, "seeAlso")
    }
  end
end

require Paddle.Class.Helper

Paddle.Class.Helper.gen_class_from_schema(
  Api.Ldap.InetOrgPerson,
  "inetOrgPerson",
  "ou=users",
  :uid
)
