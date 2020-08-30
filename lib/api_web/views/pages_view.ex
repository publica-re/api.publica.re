defmodule ApiWeb.PagesView do
  use ApiWeb, :view
  alias ApiWeb.PagesView

  def render("index.json", %{page: page}) do
    %{data: render_many(page, PagesView, "pages.json")}
  end

  def render("show.json", %{pages: pages}) do
    %{data: render_one(pages, PagesView, "pages.json")}
  end

  def render("pages.json", %{pages: pages}) do
    %{id: pages.id,
      tag: pages.tag}
  end
end
