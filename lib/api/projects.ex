defmodule Api.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Projects.Repository

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories do
    Repo.all(Repository)
  end

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id), do: Repo.get!(Repository, id)

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> Repository.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{data: %Repository{}}

  """
  def change_repository(%Repository{} = repository, attrs \\ %{}) do
    Repository.changeset(repository, attrs)
  end

  alias Api.Projects.Issue

  @doc """
  Returns the list of issues.

  ## Examples

      iex> list_issues()
      [%Issue{}, ...]

  """
  def list_issues do
    Repo.all(Issue)
  end

  @doc """
  Gets a single issue.

  Raises `Ecto.NoResultsError` if the Issue does not exist.

  ## Examples

      iex> get_issue!(123)
      %Issue{}

      iex> get_issue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_issue!(id), do: Repo.get!(Issue, id)

  @doc """
  Creates a issue.

  ## Examples

      iex> create_issue(%{field: value})
      {:ok, %Issue{}}

      iex> create_issue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_issue(attrs \\ %{}) do
    %Issue{}
    |> Issue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a issue.

  ## Examples

      iex> update_issue(issue, %{field: new_value})
      {:ok, %Issue{}}

      iex> update_issue(issue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_issue(%Issue{} = issue, attrs) do
    issue
    |> Issue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a issue.

  ## Examples

      iex> delete_issue(issue)
      {:ok, %Issue{}}

      iex> delete_issue(issue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_issue(%Issue{} = issue) do
    Repo.delete(issue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking issue changes.

  ## Examples

      iex> change_issue(issue)
      %Ecto.Changeset{data: %Issue{}}

  """
  def change_issue(%Issue{} = issue, attrs \\ %{}) do
    Issue.changeset(issue, attrs)
  end

  alias Api.Projects.MergeRequest

  @doc """
  Returns the list of mergerequests.

  ## Examples

      iex> list_mergerequests()
      [%MergeRequest{}, ...]

  """
  def list_mergerequests do
    Repo.all(MergeRequest)
  end

  @doc """
  Gets a single merge_request.

  Raises `Ecto.NoResultsError` if the Merge request does not exist.

  ## Examples

      iex> get_merge_request!(123)
      %MergeRequest{}

      iex> get_merge_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_merge_request!(id), do: Repo.get!(MergeRequest, id)

  @doc """
  Creates a merge_request.

  ## Examples

      iex> create_merge_request(%{field: value})
      {:ok, %MergeRequest{}}

      iex> create_merge_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_merge_request(attrs \\ %{}) do
    %MergeRequest{}
    |> MergeRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a merge_request.

  ## Examples

      iex> update_merge_request(merge_request, %{field: new_value})
      {:ok, %MergeRequest{}}

      iex> update_merge_request(merge_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_merge_request(%MergeRequest{} = merge_request, attrs) do
    merge_request
    |> MergeRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a merge_request.

  ## Examples

      iex> delete_merge_request(merge_request)
      {:ok, %MergeRequest{}}

      iex> delete_merge_request(merge_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_merge_request(%MergeRequest{} = merge_request) do
    Repo.delete(merge_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking merge_request changes.

  ## Examples

      iex> change_merge_request(merge_request)
      %Ecto.Changeset{data: %MergeRequest{}}

  """
  def change_merge_request(%MergeRequest{} = merge_request, attrs \\ %{}) do
    MergeRequest.changeset(merge_request, attrs)
  end

  alias Api.Projects.Pages

  @doc """
  Returns the list of page.

  ## Examples

      iex> list_page()
      [%Pages{}, ...]

  """
  def list_page do
    Repo.all(Pages)
  end

  @doc """
  Gets a single pages.

  Raises `Ecto.NoResultsError` if the Pages does not exist.

  ## Examples

      iex> get_pages!(123)
      %Pages{}

      iex> get_pages!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pages!(id), do: Repo.get!(Pages, id)

  @doc """
  Creates a pages.

  ## Examples

      iex> create_pages(%{field: value})
      {:ok, %Pages{}}

      iex> create_pages(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pages(attrs \\ %{}) do
    %Pages{}
    |> Pages.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pages.

  ## Examples

      iex> update_pages(pages, %{field: new_value})
      {:ok, %Pages{}}

      iex> update_pages(pages, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pages(%Pages{} = pages, attrs) do
    pages
    |> Pages.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pages.

  ## Examples

      iex> delete_pages(pages)
      {:ok, %Pages{}}

      iex> delete_pages(pages)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pages(%Pages{} = pages) do
    Repo.delete(pages)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pages changes.

  ## Examples

      iex> change_pages(pages)
      %Ecto.Changeset{data: %Pages{}}

  """
  def change_pages(%Pages{} = pages, attrs \\ %{}) do
    Pages.changeset(pages, attrs)
  end
end
