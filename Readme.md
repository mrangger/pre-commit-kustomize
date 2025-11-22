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
| **recursive** |By default, the hook recursively checks all files under the specified path. Can be set to `"true"`, `"false"`, or `"--no-recurse"`.|true |
| **--enable-helm** | Enable Helm chart inflation during kustomize build (requires helm to be installed). Can be used as a flag anywhere in arguments. | disabled |
| **--no-recurse** | Alternative to `"false"` for disabling recursive search. Can be used as the recursive parameter value. | - |

### Example pre-commit config

The following configuration uses `check-kustomize-build-dependencies` to validate kustomize files for build dependencies.

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies
      args: ["overlays"]
```

```

---

## 📝 YAML Extension Consistency Hook

The `check-yaml-extension` hook ensures all YAML files in your commits use a consistent file extension. It only checks files that are being committed, making it fast and efficient.

### Configuration

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.8
  hooks:
    - id: check-yaml-extension
```

### Options

| Argument | Description | Default |
|:---------|:------------|--------:|
| **--yaml** | Prefer `.yaml` extension | enabled |
| **--yml** | Prefer `.yml` extension | disabled |
| **--check-only** | Only check, don't rename files | disabled |

### Examples

**Enforce .yaml extension (default):**

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.8
  hooks:
    - id: check-yaml-extension
```

**Enforce .yml extension:**

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.8
  hooks:
    - id: check-yaml-extension
      args: ["--yml"]
```

**Check only (don't auto-rename):**

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.8
  hooks:
    - id: check-yaml-extension
      args: ["--check-only"]
```

> [!NOTE]
> This hook automatically renames files and stages them in git. When a `.yml` file is renamed to `.yaml`, the renamed file is automatically added to your commit.

---

## 🔧 Kustomize Build Validation

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

### Using with Helm Charts

If your Kustomize configurations use Helm charts (via `helmCharts` in `kustomization.yaml`), you need to enable Helm support:

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies
      args: ["overlays", "--enable-helm"]
```

Or explicitly with recursive enabled:

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies
      args: ["overlays", "true", "--enable-helm"]
```

### Disabling Recursive Search

To disable recursive search (only check the top-level directory), you can use:

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies
      args: ["overlays", "false"]
```

Or use the more explicit flag syntax:

```yaml
- repo: https://github.com/mrangger/pre-commit-kustomize
  rev: v0.0.4
  hooks:
    - id: check-kustomize-build-dependencies
      args: ["overlays", "--no-recurse"]
```

> [!NOTE]
> The `--no-recurse` flag is an alternative to `"false"` for the recursive parameter, making the configuration more explicit and consistent with the `--enable-helm` flag style.

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
docker run --rm -v $(pwd):/src pre-commit-kustomize kustomize-build overlays
```

With Helm support:

```sh
docker run --rm -v $(pwd):/src pre-commit-kustomize kustomize-build overlays true --enable-helm
```

## ❓ Troubleshooting

- Hook Fails on Commit

   - Ensure pre-commit is installed and set up correctly: `pre-commit install`

   - Run the hook manually for debugging: `pre-commit run --all-files`

- Kustomize Build Errors

  Run `kustomize build overlays/<your-environment>` manually to check for detailed error information.

- Missing Dependencies

  Ensure that both `pre-commit` and `kustomize` are installed and accessible in your system's `PATH` if you're not using the Docker-based hook.

- Helm Chart Errors

  If you're using Helm charts in your Kustomize configurations, make sure to:
  - Add the `--enable-helm` flag to your hook arguments
  - Ensure `helm` is installed and accessible in your `PATH`
  - Verify your Helm chart references are correct in `kustomization.yaml`

## 🤝 Contributing

Contributions are welcome! Please:

1. Open an issue before submitting PRs.
1. Follow the existing code and commit style.
1. Ensure your changes pass pre-commit hooks.

## 📝 License

This project is licensed under the GNU General Public License v3.0 or later.

See [COPYING](COPYING) to see the full text.
