#!/usr/bin/env bash
# Code linting script

echo "Running Flake8 linter..."
uv run flake8 backend/ main.py --max-line-length=88 --extend-ignore=E203,W503

echo "Running MyPy type checker..."
uv run mypy backend/ main.py --ignore-missing-imports

echo "Linting complete!"