defmodule Api.Ldap do
  alias Api.Accounts.User 

  alias Api.Ldap

  def authenticate(uid, password) do
    Paddle.authenticate(uid, password)
  end

  def get_by_uid(uid) do
    {:ok, [user]} = Paddle.get(filter: [uid: uid, objectClass: "inetOrgPerson"], base: [ou: "users"])
    Ldap.to_map(user)
  end

  def list() do
    {:ok, users} = Paddle.get(filter: [objectClass: "inetOrgPerson"], base: [ou: "users"])
    Enum.map(users, fn x -> Ldap.to_map(x) end)
  end

  def to_map(entry) do
    %User{username: List.first(entry["uid"] || []),
          photo: List.first(entry["photo"] || []),
          givenName: List.first(entry["givenName"] || []),
          surname: List.first(entry["sn"] || []),
          displayName: List.first(entry["displayName"] || []),
          email: List.first(entry["mail"] || []),
          phone: List.first(entry["phone"] || []),
          url: List.first(entry["labeledURI"] || [])}
  end
end