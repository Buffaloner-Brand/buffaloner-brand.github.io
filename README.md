# Base Static Site Template For Buffaloner Projects

This site uses ProperDocs and the MkDocs-Material theme

## Setup

Use `gh` commandline tool (`brew install gh`) create a directory, initialize it with git and authenticate to Github based on the instructions in STDOUT:

```shell
PROJECT="myproject"
mkdir $PROJECT
cd $PROJECT
git init
gh auth login #follow instructions if not already attempted
gh repo create $(basename $PWD) --public --source=. --remote=upstream
```

Static Github Pages need to be public to work. 

## Development

Managed with `uv` for dependency management.

`uv init --name "$(basename $(pwd))" --description "A Base Github Pages hosted static site, built with properdocs" --author-from auto --lib`

## Deployment

1. Build the site

    `uv run properdocs build`

2. Check out the gh-pages branch into a temporary folder

    `git worktree add /tmp/gh-pages gh-pages`

3. Sync the built site over (keeping the hidden .git metadata)

    `rsync -a --delete site/ /tmp/gh-pages/ --exclude=".git"`

4. Sign the commit using standard git commands, which WILL respect your config

    ```bash
    cd /tmp/gh-pages
    git add .
    git commit -S -m "docs: deploy to gh-pages"
    git push origin gh-pages
    ```
5. Clean up

    ```
    cd -
    git worktree remove /tmp/gh-pages
    ```