# clbsoldev.__COLLECTION_NAME__

__COLLECTION_DESCRIPTION__

Part of the [clbsoldev](https://github.com/clbsoldev) Collaboration
Solution Development Environment Ansible collections.

## Included Roles

| Role | Description |
|---|---|
| [`__ROLE_NAME__`](roles/__ROLE_NAME__/README.md) | __ROLE_DESCRIPTION__ |

## Installation

Via `requirements.yml` in the consuming control-node repo:

```yaml
collections:
  - name: https://github.com/clbsoldev/ansible-collection-__COLLECTION_NAME__.git
    type: git
    version: v0.1.0
```

Then:

```bash
ansible-galaxy collection install -r requirements.yml
```

## Usage

```yaml
- hosts: all
  roles:
    - role: clbsoldev.__COLLECTION_NAME__.__ROLE_NAME__
```

## Development

```bash
pip install ansible-core ansible-lint yamllint
yamllint .
ansible-lint

# One-time per clone: commit message template + local Conventional
# Commits check (this repo is pushed to directly, no PRs)
git config commit.template .gitmessage
git config core.hooksPath .githooks
chmod +x .githooks/commit-msg
```

Commits must follow [Conventional Commits](https://www.conventionalcommits.org/)
(`feat:`, `fix:`, `chore:`, ...) - `.githooks/commit-msg` blocks a bad
commit message locally before it's even created; `commit-lint.yml` is a
CI-side safety net for the case that hook was skipped. release-please
reads these commit messages directly (no squash/PR step in between).

CI runs lint + a syntax-check matrix for every role on each push/PR.
Molecule-based functional testing is intentionally deferred - see
`CONTRIBUTING.md` (or the project notes) for the rollout plan.

## Versioning

Versioning and `CHANGELOG.md` are maintained automatically by
[release-please](https://github.com/googleapis/release-please) based on
Conventional Commits. Merging the release PR it opens creates the tag,
bumps `galaxy.yml`'s `version` field, and triggers the release workflow,
which builds and publishes the collection artifact as a GitHub Release.
