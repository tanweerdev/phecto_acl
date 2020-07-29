defmodule PhEctoAcl.SeedHelper do
  def priv_path_for(filename, opts \\ []) do
    app = opts[:app] || :acl
    repo_underscore = opts[:repo_underscore] || "repo"

    priv_dir = "#{:code.priv_dir(app)}"

    if opts[:nested_folder] do
      Path.join([priv_dir, repo_underscore, opts[:nested_folder], filename])
    else
      Path.join([priv_dir, repo_underscore, filename])
    end
  end

  # TODO: missing tests
  def join_with_priv_path(app, path) do
    priv_dir = "#{:code.priv_dir(app)}"

    Path.join([priv_dir, path])
  end

  def ignore_csv_bom(line) do
    if String.starts_with?(line, "\ufeff") do
      String.replace(line, "\ufeff", "")
    else
      line
    end
  end
end
