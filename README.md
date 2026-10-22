# Personal technical blog

A deliberately small Hugo site. Its only dependencies are pinned by Nix, and the
published site is a static directory.

## Work locally

1. Replace the placeholder `baseURL`, title, and description in `hugo.toml`.
2. Enter the reproducible development shell: `nix develop`.
3. Run `hugo server --buildDrafts` and open the address Hugo prints.

Build the exact site CI builds with `nix build .#site`. The resulting directory
is available at `result/`.

## Write a post

Add a Markdown file under `content/posts/`. Set `draft: false` when it is ready
to publish. Hugo's front matter format is shown in the sample post.

## GitHub Pages setup

1. Create a GitHub repository and push this project.
2. In **Settings → Pages**, set **Source** to **GitHub Actions**.
3. Change `baseURL` to `https://<owner>.github.io/<repository>/` (or your custom
   domain). For a user/organisation Pages repository, omit the repository path.
4. Commit the generated `flake.lock` after your first `nix flake lock`.

The production workflow uses GitHub's official Pages deployment actions. It runs
for pushes to `main` and exposes the deployment in the `github-pages`
environment.
