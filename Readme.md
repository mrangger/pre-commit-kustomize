[![Repository License](https://img.shields.io/badge/license-GPL%20v3.0-brightgreen.svg)](COPYING)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/mrangger/pre-commit-kustomize/master.svg)](https://results.pre-commit.ci/latest/github/mrangger/pre-commit-kustomize/master)

# Kustomize hook for pre-commit

Run kustomize build to check kustomize targets for build dependencies

## Example pre-commit config

The following configuration uses `check-kustomize-build-dependencies` to validate kustomize files for build dependencies.

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.1
  hooks:
    - id: check-kustomize-build-dependencies
      args:
        - "overlays"
        - "kustomization.yaml"
```

## License

GNU General Public License v3.0 or later

See [COPYING](COPYING) to see the full text.
