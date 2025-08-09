#!/usr/bin/env bash
# Code formatting script

echo "Running Black formatter..."
uv run black backend/ main.py

echo "Running isort import sorter..."
uv run isort backend/ main.py

echo "Code formatting complete!"