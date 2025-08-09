#!/usr/bin/env bash
# Complete code quality check script

echo "🔧 Running code quality checks..."
echo

echo "📝 Step 1: Formatting code..."
./scripts/format.sh
echo

echo "🔍 Step 2: Running linters..."
./scripts/lint.sh
echo

echo "✅ Code quality checks complete!"