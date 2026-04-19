#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# pnpm
pnpm i --frozen-lockfile

# uv
uv sync

# create directories
mkdir -p "$repo_root/functions"
mkdir -p "$repo_root/resources"
mkdir -p "$repo_root/tasks"

# skills idapython
repo="https://github.com/mrexodia/ida-pro-mcp.git"
ref="aaebe5f1b93d9a80173019de7ae1cf8bc048ee89"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git init "$tmp/repo"
cd "$tmp/repo"
git remote add origin "$repo"
git fetch --depth 1 --filter=blob:none origin "$ref"
git checkout --detach FETCH_HEAD
git sparse-checkout set skills/idapython

rm -rf "$repo_root/.skills/idapython"
mkdir -p "$repo_root/.skills"
cp -R skills/idapython "$repo_root/.skills/idapython"
