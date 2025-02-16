[![Repository License](https://img.shields.io/badge/license-GPL%20v3.0-brightgreen.svg)](COPYING)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/mrangger/pre-commit-kustomize/master.svg)](https://results.pre-commit.ci/latest/github/mrangger/pre-commit-kustomize/master)

# 🔧 Kustomize hook for pre-commit

**pre-commit-kustomize** is a [pre-commit](https://pre-commit.com)-hook hook that ensures your [Kustomize](https://kustomize.io) configurations are valid by running `kustomize build`. This helps detect Kubernetes resource errors early and ensures configuration integrity.

## 🚀 Quick Start

1. Install pre-commit

   If you haven't installed `pre-commit`, do so with:

   ```bash
   pip install pre-commit
   ```

1. Add pre-commit-kustomize to your Config

   Create or update your `.pre-commit-config.yaml`:

   ```yaml
   - repo: https://github.com/mrangger/pre-commit-kustomize
     rev: v0.0.4
     hooks:
       - id: check-kustomize-build-dependencies
         args: ["overlays"]
   ```

1. Install the Hook locally

   Run the following command to set up `pre-commit` in your repo:

   ```bash
   pre-commit install
   ```

1. Run the Hook manually (optional)

   Once installed, the hook validates the Kustomize builds for the specified overlays on every commit. To manually run the hook against all files, use:

   ```sh
   pre-commit run --all-files
   ```

## 🛠️ Configuration Options

The `check-kustomize-build-dependencies` hook accepts the following arguments:

| Argument | Description | Default |
|:------------- |:------------- | -----:|
| **Path to the overlay:** | The directory containing the `kustomization.yaml` file (e.g., `overlays/development`) | `overlays` |
| **recursive** |By default, the hook recursively checks all files under the specified path.|true |

### Example pre-commit config

The following configuration uses `check-kustomize-build-dependencies` to validate kustomize files for build dependencies.

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies
      args: ["overlays"]
```

You can define multiple instances of the hook to validate different overlays:

```yaml
repos:
  - repo: https://github.com/mrangger/pre-commit-kustomize
    rev: v0.0.4
    hooks:
      - id: check-kustomize-build-dependencies
        name: kustomize-development
        args: ["overlays/development"]
      - id: check-kustomize-build-dependencies
        name: kustomize-staging
        args: ["overlays/staging"]
      - id: check-kustomize-build-dependencies
        name: kustomize-production
        args: ["overlays/production"]
```

### 🐳 Using with Docker

The following configuration uses `check-kustomize-build-dependencies-docker` to validate kustomize files for build dependencies. This hook runs inside a Docker container and does not requiere kustomize to be installed locally.

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies-docker
      args: ["overlays"]
```

Run manually:

```sh
docker run --rm -v $(pwd):/src pre-commit-kustomize check-kustomize-build-dependencies overlays
```

## ❓ Troubleshooting

- Hook Fails on Commit

   - Ensure pre-commit is installed and set up correctly: `pre-commit install`

   - Run the hook manually for debugging: `pre-commit run --all-files`

- Kustomize Build Errors

  Run `kustomize build overlays/<your-environment>` manually to check for detailed error information.

- Missing Dependencies

  Ensure that both `pre-commit` and `kustomize` are installed and accessible in your system's `PATH` if you're not using the Docker-based hook.

## 🤝 Contributing

Contributions are welcome! Please:

1. Open an issue before submitting PRs.
1. Follow the existing code and commit style.
1. Ensure your changes pass pre-commit hooks.

## 📝 License

This project is licensed under the GNU General Public License v3.0 or later.

See [COPYING](COPYING) to see the full text.
