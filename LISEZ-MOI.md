# Claude N Works — les exercices

Des exercices courts, un par répertoire, pour **voir ce que Claude Code fait en dessous**.
Chacun produit une session réelle, qu'on regarde ensuite dans
[Claude N Works](https://github.com/YvesThenElse/Claude-N-works).

Le public visé connaît déjà Claude Code. Ce qu'on vient chercher ici n'est pas comment
s'en servir, c'est **ce qui se passe quand on s'en sert**.

## La boucle, une fois pour toutes

```sh
git clone https://github.com/YvesThenElse/Claude-N-Works-formation
cd Claude-N-Works-formation/01-lire-une-session
./demarrer.sh            # lance Claude Code, isolé
# … on fait l'exercice en suivant le LISEZ-MOI.md du répertoire …
./remise-a-zero.sh       # le répertoire redevient neuf
```

**Sous Windows** (cmd, PowerShell, cmder), utilisez les équivalents `.cmd`, présents dans
chaque exercice : `demarrer.cmd` et `remise-a-zero.cmd`. Ne passez pas par
`bash demarrer.sh` : le bash de WSL ne voit pas le `claude` installé côté Windows
(*« exec: claude: not found »*).

Quand tout est fini, **supprimez le clone**. Rien n'est à garder, rien n'est à pousser :
les exercices sont du terrain d'entraînement, pas du travail.

> **Au tout premier lancement**, Claude Code demande si le répertoire est de confiance.
> Répondez oui. Sans cela les permissions déclarées par l'exercice sont ignorées — mesuré :
> *« Ignoring 5 permissions.allow entries from .claude/settings.json: this workspace has
> not been trusted »* — et l'agent s'arrête pour demander au lieu d'agir.
>
> Bonne nouvelle, mesurée elle aussi : **la confiance porte sur la racine du dépôt git**,
> pas sur chaque sous-répertoire. Une seule acceptation vaut pour tous les exercices du
> clone.

## Pourquoi `./demarrer.sh` et pas `claude`

Parce qu'un `claude` ordinaire hérite de **votre** configuration : vos serveurs MCP, vos
skills, vos réglages. Votre écran ne ressemblerait alors pas à celui des captures, et la
leçon se noierait dans votre outillage.

Le script lance donc Claude Code isolé :

```sh
claude --strict-mcp-config --mcp-config .mcp.json --setting-sources project
```

Mesuré sur un exercice d'essai : **un seul serveur MCP au lieu de quatre, 20 outils
offerts au lieu de 89.** Ce que vous verrez est ce que l'exercice déclare, et rien d'autre.

## Regarder ce qui s'est passé

Installez l'observateur — [le binaire de votre système][versions] — et ouvrez-le. Chaque
exercice apparaît comme **sa propre session**, parce que Claude Code range les transcripts
par répertoire de travail.

[versions]: https://github.com/YvesThenElse/Claude-N-works/releases/latest

## Les exercices

| | Ce qu'on y voit |
|---|---|
| [`01-lire-une-session`](01-lire-une-session/) | le vocabulaire de l'écran : un tour, un appel d'outil, une réflexion |
| [`02-les-hooks`](02-les-hooks/) | ce qui s'exécute **autour** de chaque geste, et ce que coûte un hook |

*D'autres suivent.*
