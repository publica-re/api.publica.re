defmodule ApiWeb.UserView do
  use ApiWeb, :view
  alias ApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{username: user.username,
      photo: Base.encode64(user.photo || "") || nil,
      givenName: user.givenName,
      surname: user.surname,
      displayName: user.displayName,
      email: user.email,
      phone: user.phone,
      url: user.url,
    }
  end 
  
  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end