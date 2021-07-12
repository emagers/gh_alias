# gh_alias

A set of custom [GitHub CLI](https://cli.github.com/) API calls that can be added as aliases. This is a collection I have found useful, but if you have suggestions, requests, or otherwise feel free to create an issue.

# Getting Started with GitHub CLI

Visit [GitHub](https://cli.github.com/) for instructions on how to install the GitHub CLI and for documentation on how to use it.

# Running a command

## Running a command

Each file in the [commands](./commands) directory is its own gh CLI command. You can copy the command and run it in the CLI by prefixing `gh`. For example, you can run the command in [view_prs](./commands/view_prs) by executing: 

```
gh api graphql -f query='{
  search(query: "is:open is:pr review-requested:@me ", type: ISSUE, first: 100) {
    edges {
      node {
        ... on PullRequest {
          title
          url
          repository {
            name
          },
          author {
            login
          }
          createdAt
          updatedAt
        }
      }
    }
  }
}' --jq '.data.search.edges[] | {repository: .node.repository.name, title: .node.title, url: .node.url, author: .node.author.login, createdAt: .node.createdAt, updatedAt: .node.updatedAt}'
```

## Running a command with an alias

To simplify running the commands, you can register tham as an alias with the CLI. To do this, run the following command: `gh alias set <command name> - < <path/filename>`

For example, to register the [view_prs](./commands/view_prs) command with the name `view_prs` on the CLI, you can run: `gh alias set view_prs - < ~/gh_alias/view_prs`, assuming the repository is cloned into your home directory.

Once the command has been registered, you can call it directly: `gh view_prs`

# Register all aliases

To simplify the set up of each command, you can run [register.sh](register.sh). This script will iterate over each file in [commands](./commands) and register each as an alias that is the same as the files name.

# Modifying commands

If a modification is made, the modified command will need to have its alias updated. Either manually setting the alias or using the register script will work.