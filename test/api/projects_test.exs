defmodule Api.ProjectsTest do
  use Api.DataCase

  alias Api.Projects

  describe "repositories" do
    alias Api.Projects.Repository

    @valid_attrs %{name: "some name", physical: "some physical", slug: "some slug"}
    @update_attrs %{name: "some updated name", physical: "some updated physical", slug: "some updated slug"}
    @invalid_attrs %{name: nil, physical: nil, slug: nil}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Projects.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Projects.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Projects.create_repository(@valid_attrs)
      assert repository.name == "some name"
      assert repository.physical == "some physical"
      assert repository.slug == "some slug"
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{} = repository} = Projects.update_repository(repository, @update_attrs)
      assert repository.name == "some updated name"
      assert repository.physical == "some updated physical"
      assert repository.slug == "some updated slug"
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_repository(repository, @invalid_attrs)
      assert repository == Projects.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = Projects.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = Projects.change_repository(repository)
    end
  end

  describe "issues" do
    alias Api.Projects.Issue

    @valid_attrs %{content: "some content", title: "some title"}
    @update_attrs %{content: "some updated content", title: "some updated title"}
    @invalid_attrs %{content: nil, title: nil}

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_issue()

      issue
    end

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Projects.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Projects.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      assert {:ok, %Issue{} = issue} = Projects.create_issue(@valid_attrs)
      assert issue.content == "some content"
      assert issue.title == "some title"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{} = issue} = Projects.update_issue(issue, @update_attrs)
      assert issue.content == "some updated content"
      assert issue.title == "some updated title"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_issue(issue, @invalid_attrs)
      assert issue == Projects.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Projects.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Projects.change_issue(issue)
    end
  end

  describe "mergerequests" do
    alias Api.Projects.MergeRequest

    @valid_attrs %{remote_branch: "some remote_branch", target_branch: "some target_branch"}
    @update_attrs %{remote_branch: "some updated remote_branch", target_branch: "some updated target_branch"}
    @invalid_attrs %{remote_branch: nil, target_branch: nil}

    def merge_request_fixture(attrs \\ %{}) do
      {:ok, merge_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_merge_request()

      merge_request
    end

    test "list_mergerequests/0 returns all mergerequests" do
      merge_request = merge_request_fixture()
      assert Projects.list_mergerequests() == [merge_request]
    end

    test "get_merge_request!/1 returns the merge_request with given id" do
      merge_request = merge_request_fixture()
      assert Projects.get_merge_request!(merge_request.id) == merge_request
    end

    test "create_merge_request/1 with valid data creates a merge_request" do
      assert {:ok, %MergeRequest{} = merge_request} = Projects.create_merge_request(@valid_attrs)
      assert merge_request.remote_branch == "some remote_branch"
      assert merge_request.target_branch == "some target_branch"
    end

    test "create_merge_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_merge_request(@invalid_attrs)
    end

    test "update_merge_request/2 with valid data updates the merge_request" do
      merge_request = merge_request_fixture()
      assert {:ok, %MergeRequest{} = merge_request} = Projects.update_merge_request(merge_request, @update_attrs)
      assert merge_request.remote_branch == "some updated remote_branch"
      assert merge_request.target_branch == "some updated target_branch"
    end

    test "update_merge_request/2 with invalid data returns error changeset" do
      merge_request = merge_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_merge_request(merge_request, @invalid_attrs)
      assert merge_request == Projects.get_merge_request!(merge_request.id)
    end

    test "delete_merge_request/1 deletes the merge_request" do
      merge_request = merge_request_fixture()
      assert {:ok, %MergeRequest{}} = Projects.delete_merge_request(merge_request)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_merge_request!(merge_request.id) end
    end

    test "change_merge_request/1 returns a merge_request changeset" do
      merge_request = merge_request_fixture()
      assert %Ecto.Changeset{} = Projects.change_merge_request(merge_request)
    end
  end

  describe "page" do
    alias Api.Projects.Pages

    @valid_attrs %{tag: "some tag"}
    @update_attrs %{tag: "some updated tag"}
    @invalid_attrs %{tag: nil}

    def pages_fixture(attrs \\ %{}) do
      {:ok, pages} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_pages()

      pages
    end

    test "list_page/0 returns all page" do
      pages = pages_fixture()
      assert Projects.list_page() == [pages]
    end

    test "get_pages!/1 returns the pages with given id" do
      pages = pages_fixture()
      assert Projects.get_pages!(pages.id) == pages
    end

    test "create_pages/1 with valid data creates a pages" do
      assert {:ok, %Pages{} = pages} = Projects.create_pages(@valid_attrs)
      assert pages.tag == "some tag"
    end

    test "create_pages/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_pages(@invalid_attrs)
    end

    test "update_pages/2 with valid data updates the pages" do
      pages = pages_fixture()
      assert {:ok, %Pages{} = pages} = Projects.update_pages(pages, @update_attrs)
      assert pages.tag == "some updated tag"
    end

    test "update_pages/2 with invalid data returns error changeset" do
      pages = pages_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_pages(pages, @invalid_attrs)
      assert pages == Projects.get_pages!(pages.id)
    end

    test "delete_pages/1 deletes the pages" do
      pages = pages_fixture()
      assert {:ok, %Pages{}} = Projects.delete_pages(pages)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_pages!(pages.id) end
    end

    test "change_pages/1 returns a pages changeset" do
      pages = pages_fixture()
      assert %Ecto.Changeset{} = Projects.change_pages(pages)
    end
  end
end
