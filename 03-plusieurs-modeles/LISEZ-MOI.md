# 03 — Plusieurs modèles dans une même session

**Durée : 10 minutes.** Ce qu'on vient voir : une session n'a pas **un** modèle. L'agent
principal en a un, et chaque **sous-agent** peut en avoir un autre, choisi selon la tâche.
Le comptage part chez un petit modèle rapide, le jugement chez un modèle plus fin.

## La brigade

| Qui | Modèle | Déclaré dans | Son travail |
|---|---|---|---|
| l'agent principal | **Opus** | `.claude/settings.json` (`"model": "opus"`) | il répartit le travail et écrit le compte rendu |
| le **commis** | **Haiku** | `.claude/agents/commis.md` (`model: haiku`) | il compte : couverts et plats, sans avis |
| le **sommelier** | **Sonnet** | `.claude/agents/sommelier.md` (`model: sonnet`) | il juge : un vin par plat, et pourquoi |

Ouvrez les deux fichiers de `.claude/agents/` : un sous-agent, c'est un nom, une
description (qui dit à l'agent principal **quand** l'employer), un modèle, des outils, et
ses consignes.

## Faire

```sh
./demarrer.sh            # sous Windows : demarrer.cmd
```

Puis, dans Claude Code, une seule phrase :

> Fais compter les commandes de `commande/` par le commis, et demande en même temps au
> sommelier un vin pour chaque plat. Puis écris dans `resultat/service.md` le total de
> couverts, le nombre de fois que chaque plat est demandé, et le vin proposé pour chacun.

## Regarder

Ouvrez la session dans Claude N Works. Vous devez voir, sous l'agent principal,
**deux sous-agents** qui travaillent **en même temps** — leurs barres se chevauchent.

Cliquez sur chaque barre d'agent : sa carte donne son **modèle**. Relevé lors de la mise
au point de l'exercice :

| Transcript | Modèle |
|---|---|
| la session principale | celui de `settings.json` |
| le sous-agent `commis` | `claude-haiku-…` |
| le sous-agent `sommelier` | `claude-sonnet-…` |

Chaque sous-agent a **son propre transcript**, rangé à part
(`…/<session>/subagents/agent-….jsonl`). C'est pour cela que l'observateur peut les
montrer chacun avec son modèle.

## Les trois questions

1. Lequel des deux sous-agents a fini le premier ? Est-ce celui qui avait le plus de
   travail, ou celui qui avait le modèle le plus rapide ?
2. Comparez les jetons consommés par chaque agent. Où part l'essentiel du coût de la
   session ?
3. Qu'est-ce que l'agent principal a réellement fait lui-même, et qu'a-t-il délégué ?

## Pour aller plus loin

Changez `model: haiku` en `model: sonnet` dans `commis.md`, remettez à zéro, relancez :
le comptage est-il meilleur, plus lent, plus cher ? Pour une tâche sans jugement, le gros
modèle n'apporte souvent que du délai.

## Terminer

```sh
./remise-a-zero.sh       # sous Windows : remise-a-zero.cmd
```
