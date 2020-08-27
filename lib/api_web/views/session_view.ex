defmodule ApiWeb.SessionView do
  use ApiWeb, :view

  def render("success.json", %{jwt: jwt, claims: claims}) do
    %{
      status: "success",
      jwt: jwt,
      claims: claims
    }
  end

  def render("failure.json", %{}) do
    %{status: "failure", reason: "invalid credentials or non-existent user"}
  end

  def render("signout.json", %{}) do
    %{status: "success"}
  end
end
