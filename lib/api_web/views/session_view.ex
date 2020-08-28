defmodule ApiWeb.SessionView do
  use ApiWeb, :view

  def render("success.json", %{jwt: jwt, claims: claims}) do
    %{
      status: "success",
      jwt: jwt,
      claims: claims
    }
  end

  def render("failure.json", %{reason: reason}) do
    %{status: "failure", reason: reason}
  end

  def render("signout.json", %{}) do
    %{status: "success"}
  end
end
