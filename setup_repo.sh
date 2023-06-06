#!/bin/bash

# !!!NOTICE!!
# Personal token with full access rights is required to run this scripts
# Once you got persona token, set enviroment variable GH_TOKEN with it

# Take interactive input <package-name>, <email> and <github-username> from user
read -p "Enter package name: " package_name
read -p "Description: " description
read -p "Enter github username: " github_username
read -p "Enter email: " email

# Enable workflows
mv .github/workflows/dev.yml.rename .github/workflows/dev.yml
mv .github/workflows/release.yml.rename .github/workflows/release.yml

# Rename README.md.rename to README.md
mv README.md.rename README.md

# Replace <package-name>, <email> and <github-username> in README.md, docs/installation.md, mkdocs.yml, pyproject.toml
sed -i "s/<package-name>/$package_name/g" README.md
sed -i "s/<package-name>/$package_name/g" docs/installation.md
sed -i "s/<package-name>/$package_name/g" mkdocs.yml
sed -i "s/<package-name>/$package_name/g" pyproject.toml
sed -i "s/<package-name>/$package_name/g" .github/workflows/release.yml

sed -i "s/<github-username>/$github_username/g" README.md
sed -i "s/<github-username>/$github_username/g" docs/installation.md
sed -i "s/<github-username>/$github_username/g" mkdocs.yml
sed -i "s/<github-username>/$github_username/g" pyproject.toml
sed -i "s/<github-username>/$github_username/g" .github/workflows/release.yml

sed -i "s/<email>/$email/g" README.md
sed -i "s/<email>/$email/g" docs/installation.md
sed -i "s/<email>/$email/g" mkdocs.yml
sed -i "s/<email>/$email/g" pyproject.toml
sed -i "s/<email>/$email/g" .github/workflows/release.yml

sed -i "s/<description>/$description/g" README.md
sed -i "s/<description>/$description/g" pyproject.toml

# uncomment the following to init repo and push code to github
git add .
pre-commit run --all-files
git add .
git commit -m "Setup repo"
git branch -M main

# Uncomment the following to config github secret used by github workflow.
#gh secret set PERSONAL_TOKEN --body $GH_TOKEN
#gh secret set PYPI_API_TOKEN --body $PYPI_API_TOKEN
#gh secret set TEST_PYPI_API_TOKEN --body $TEST_PYPI_API_TOKEN

git push -u origin main
