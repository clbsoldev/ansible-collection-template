#!/usr/bin/env bash
# Run this ONCE right after creating a new repo from this template.
# Example:
#   ./bootstrap.sh linux linux_os_updates "Linux base roles" "Linux OS update management"
#
# Usage: ./bootstrap.sh <collection_name> <role_name> <collection_description> <role_description>
set -euo pipefail

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <collection_name> <role_name> <collection_description> <role_description>"
  echo "Example: $0 linux linux_os_updates 'Linux base roles' 'Linux OS update management'"
  exit 1
fi

COLLECTION_NAME="$1"
ROLE_NAME="$2"
COLLECTION_DESC="$3"
ROLE_DESC="$4"
ROLE_NAME_LOWER_UNDERSCORE="${ROLE_NAME//-/_}"
RELEASE_DATE="$(date +%Y-%m-%d)"

echo "==> Renaming roles/EXAMPLE_ROLE -> roles/${ROLE_NAME}"
git mv "roles/EXAMPLE_ROLE" "roles/${ROLE_NAME}" 2>/dev/null || mv "roles/EXAMPLE_ROLE" "roles/${ROLE_NAME}"

echo "==> Replacing placeholders in all tracked text files"
FILES=$(grep -rIl \
  -e "__COLLECTION_NAME__" \
  -e "__COLLECTION_DESCRIPTION__" \
  -e "__ROLE_NAME__" \
  -e "__ROLE_DESCRIPTION__" \
  -e "__role_name__" \
  -e "__RELEASE_DATE__" \
  -e "EXAMPLE_ROLE" \
  . --exclude-dir=.git || true)

for f in $FILES; do
  sed -i \
    -e "s/__COLLECTION_NAME__/${COLLECTION_NAME}/g" \
    -e "s/__COLLECTION_DESCRIPTION__/${COLLECTION_DESC}/g" \
    -e "s/__ROLE_NAME__/${ROLE_NAME}/g" \
    -e "s/__ROLE_DESCRIPTION__/${ROLE_DESC}/g" \
    -e "s/__role_name__/${ROLE_NAME_LOWER_UNDERSCORE}/g" \
    -e "s/__RELEASE_DATE__/${RELEASE_DATE}/g" \
    -e "s/EXAMPLE_ROLE/${ROLE_NAME}/g" \
    "$f"
done

echo "==> Done. Review the diff, then:"
echo "    git add -A && git commit -m 'chore: bootstrap collection clbsoldev.${COLLECTION_NAME}'"
echo ""
echo "Don't forget to delete this script once satisfied:"
echo "    rm bootstrap.sh"
