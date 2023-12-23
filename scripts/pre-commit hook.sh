#!/bin/bash

# Install pre-commit
curl https://pre-commit.com/install-local.py | python3 -

# Create .pre-commit-config.yaml
cat > .pre-commit-config.yaml <<EOL
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.16.1
    hooks:
      - id: gitleaks
EOL

# Auto-update the config to the latest repos' versions
pre-commit autoupdate

# Install pre-commit hooks
pre-commit install

echo "pre-commit and gitleaks configured and installed successfully."

