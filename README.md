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

`uv init --name "$(basename $(pwd))" --description "A static site built with properdocs" --author-from auto --lib`

Any build or deployment hooks meant for things such as ETL processes should go in the `src` module.

## Deployment

### Configuration

On Github, got to 'Settings', click on 'Pages', use 'Deploy from a Branch'. Set 'Branch' to `gh-pages` and choose /(root), then 'Save'

### Commands

1. Build the site

    `uv run properdocs build`

2. Deploy with `properdocs`

    `uv run properdocs gh-deploy --clean`

