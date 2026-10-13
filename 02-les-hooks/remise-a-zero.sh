#!/bin/sh
# Rend à l'exercice son état d'origine : tout ce qu'il a produit est non versionné,
# donc un nettoyage suffit. À lancer avant de refaire l'exercice.
cd "$(dirname "$0")" || exit 1
git clean -xdf . >/dev/null 2>&1 \
  || { echo "hors d'un dépôt git : supprimez resultat/ et journal.ndjson à la main"; exit 1; }
echo "exercice remis à neuf."
