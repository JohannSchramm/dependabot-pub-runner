# Dependabot Pub Runner

A GitHub Action using a dart pub ecosystem [Dependabot](https://github.com/dependabot/dependabot-core) gem to create dependency update pull requests.

## About

The runner is work in progress and is using this fork: https://github.com/JohannSchramm/dependabot-core/tree/wip/pub

The runner is a modified version of the [dependabot-script](https://github.com/dependabot/dependabot-script) update script.

## Inputs

| Name      | Description                                          | Default           |
| --------- | ---------------------------------------------------- | ----------------- |
| `token`   | Persornal access token used to modify the repository | github.token      |
| `project` | The repository you want to create pull requests for  | github.repository |
| `path`    | The path of the pubspec.yaml                         | '/'               |

## Example Workflow

```
name: Dependabot Pub

on:
  schedule:
    - cron: '0 6 * * *'

jobs:
  pub:
    name: Dependabot Pub
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Update
        uses: JohannSchramm/dependabot-pub-runner@main
        with:
          path: /frontend
```

See [dependabot-pub-example](https://github.com/JohannSchramm/dependabot-pub-example) for working example pull requests.
