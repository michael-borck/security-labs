#!/usr/bin/env bash
#
# Scaffold a new lab in the Assume-Breach series house style.
#
#   ./create-lab.sh <lab-slug> ["Lab Title"]
#
# Copies template/ into a sibling ../<lab-slug>/ directory, substitutes the name
# throughout, and prints next steps. Does not touch git or GitHub — that's up to you.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$REPO_DIR/template"

# --- args ---------------------------------------------------------------------
if [ $# -lt 1 ]; then
  echo "usage: ./create-lab.sh <lab-slug> [\"Lab Title\"]"
  echo "example: ./create-lab.sh dns-poisoning \"DNS Poisoning\""
  exit 1
fi
SLUG="$1"
if ! printf '%s' "$SLUG" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$'; then
  echo "Lab slug must be kebab-case (lowercase letters, digits, hyphens): got '$SLUG'"
  exit 1
fi

# Title: use $2, else Title-Case the slug (my-new-lab -> My New Lab)
if [ $# -ge 2 ] && [ -n "$2" ]; then
  TITLE="$2"
else
  TITLE="$(printf '%s' "$SLUG" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}}1')"
fi

# Owner: GitHub login if available, else git user, else a placeholder.
OWNER="$(gh api user --jq .login 2>/dev/null || true)"
[ -z "$OWNER" ] && OWNER="$(git config user.name 2>/dev/null || true)"
[ -z "$OWNER" ] && OWNER="your-github-username"

TARGET="$(cd "$REPO_DIR/.." && pwd)/$SLUG"
if [ -e "$TARGET" ]; then
  echo "Refusing to overwrite: $TARGET already exists."
  exit 1
fi

# --- copy ---------------------------------------------------------------------
echo "Scaffolding '$TITLE' -> $TARGET"
mkdir -p "$TARGET"
# copy everything except macOS AppleDouble sidecars
( cd "$TEMPLATE" && find . -type d -exec mkdir -p "$TARGET/{}" \; )
( cd "$TEMPLATE" && find . -type f ! -name '._*' -print0 | while IFS= read -r -d '' f; do
    cp "$f" "$TARGET/$f"
  done )

# --- substitute ---------------------------------------------------------------
# __LAB_SLUG__ __LAB_TITLE__ __OWNER__  (portable sed for GNU + BSD/macOS)
find "$TARGET" -type f ! -name '._*' -print0 | while IFS= read -r -d '' f; do
  sed -i.bak \
    -e "s/__LAB_SLUG__/$SLUG/g" \
    -e "s/__LAB_TITLE__/$TITLE/g" \
    -e "s/__OWNER__/$OWNER/g" \
    "$f" && rm -f "$f.bak"
done

# --- executables --------------------------------------------------------------
chmod +x "$TARGET/start.sh" "$TARGET/start.command" "$TARGET/scripts/lab-console" 2>/dev/null || true

# --- done ---------------------------------------------------------------------
cat <<EOF

  ✓ Scaffolded $SLUG in the house style at:
      $TARGET

  Next:
    1. cd "$TARGET"
    2. Edit docker-compose.yml     — model your hosts + network segment(s)
    3. Write LAB-GUIDE.md          — the phased walkthrough
    4. Edit docs/index.html hero   — your one-line pitch
    5. Try it:  ./start.sh   (or: make run)
    6. Set the LICENSE copyright name and, when ready:
         git init && gh repo create $OWNER/$SLUG --public --source=. --push
    7. Add this lab to the Series strip in the other labs + the hub page.

  Architecture + conventions: $REPO_DIR/ARCHITECTURE.md , CONTRIBUTING.md
EOF
