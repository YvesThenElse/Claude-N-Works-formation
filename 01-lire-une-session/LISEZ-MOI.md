# 01 — Lire une session

**Durée : 10 minutes.** Ce qu'on vient voir : le vocabulaire de l'écran. Un **tour**, un
**appel d'outil**, une **réflexion**, un **fichier écrit**. La session est volontairement
minuscule — on doit pouvoir la lire en entier, d'un coup d'œil.

## Faire

```sh
./demarrer.sh
```

Puis, dans Claude Code, une seule phrase :

> Lis les trois commandes dans `commande/`, et écris dans `resultat/service.md` le total
> de couverts et le nombre de fois que chaque plat est demandé.

## Regarder

Ouvrez la session dans Claude N Works. Dans le menu **voies**, décochez tout sauf
**tours** et **outils**.

Vous devez voir, dans l'ordre :

| Ce que vous voyez | Ce que c'est |
|---|---|
| une barre d'agent, en haut | la session entière, du début à la fin |
| **une seule** barre sur la voie *tours* | un tour : de votre phrase jusqu'au moment où l'agent rend la main |
| trois marques rapprochées | les trois `Read`, un par fichier de commande |
| une marque isolée à la fin | le `Write` du compte rendu |

Puis cochez **réflexion**. Les barres qui apparaissent sont les moments où le modèle a
réfléchi avant de répondre — leur hauteur suit la racine du nombre de jetons de réflexion.
S'il n'y en a aucune, c'est un signal aussi : ce tour-là n'a pas demandé à réfléchir.

Cliquez enfin sur la barre de l'agent. Sa carte donne son **modèle**, son **effort**, son
**répertoire de travail** — et ses outils employés, comptés un par un.

## Les trois questions

1. Combien de temps la session a-t-elle duré, et combien de temps l'agent a-t-il
   **réellement travaillé** ? (la voie *tours* répond à la seconde)
2. Y a-t-il un écart entre le nombre d'appels d'outils et le nombre de fichiers lus ?
3. Dans la carte de l'agent, son répertoire de travail est-il bien celui de l'exercice ?

## Terminer

```sh
./remise-a-zero.sh
```
