# 02 — Les hooks : ce qui s'exécute autour de chaque geste

**Durée : 10 minutes.** Ce qu'on vient voir : les hooks décident de ce qui a le droit de se
produire, ils coûtent du temps à **chaque** appel d'outil — et **tous ne sont pas visibles
de la même façon**. C'est la surprise de l'exercice.

## Faire

```sh
./demarrer.sh
```

Puis, dans Claude Code, une seule phrase :

> Lance `echo plat-accepte`, puis lance `echo plat-renvoye`. Dis-moi ce qui s'est passé
> pour chacune.

## Ce qui va se passer

Cet exercice déclare trois hooks dans son `.claude/settings.json` :

| Hook | Ce qu'il fait |
|---|---|
| `PreToolUse` sur `Bash` | écrit la commande dans `journal-des-hooks.txt` et **attend 150 ms** |
| `PreToolUse` sur `Bash` | **refuse** toute commande contenant `plat-renvoye` |
| `PostToolUse` sur `Bash` | écrit `APRÈS` dans le journal |

Le second est un **chef de rang qui goûte le plat avant l'envoi**. Il refuse en écrivant
sur sa sortie standard :

```json
{"hookSpecificOutput":{"hookEventName":"PreToolUse",
  "permissionDecision":"deny","permissionDecisionReason":"…"}}
```

## Regarder — ① le journal

```sh
cat journal-des-hooks.txt
```

Relevé lors de la mise au point de l'exercice :

```
23:03:16.843  AVANT  echo plat-accepte
23:03:17.067  AVANT  echo plat-renvoye
23:03:17.068  REFUS
23:03:17.365  APRÈS
```

Lisez-le de près : la commande refusée a bien son **AVANT**, et elle n'a **pas d'APRÈS**.
Le `PostToolUse` ne s'est pas déclenché, parce que l'outil n'a jamais tourné. Le hook
s'est interposé entre la décision de l'agent et l'exécution.

## Regarder — ② l'observateur, et la surprise

Ouvrez la session dans Claude N Works, et ne gardez que les voies **outils** et **hooks**.

**Vos trois hooks n'y sont pas.**

Ce n'est pas un défaut de l'observateur, c'est une propriété de la trace, et elle a été
mesurée sur cet exercice précis :

| Source du hook | Il s'exécute | Il est enregistré dans le transcript |
|---|---|---|
| `~/.claude/settings.json` — **votre** configuration | oui | **oui** |
| `.claude/settings.json` — **le dépôt** observé | **oui** | **non, aucune trace** |

La preuve est propre : lancé par `./demarrer.sh`, qui exclut votre configuration
personnelle, l'exercice produit **zéro** enregistrement de hook — alors que le journal
ci-dessus prouve que les hooks ont tourné et que l'agent vous a rapporté le refus.

## Ce qu'il faut en retenir

Un hook de projet **agit sans laisser de trace**. Il peut refuser une commande, en modifier
l'entrée, injecter du texte dans la conversation — et rien de tout cela n'apparaîtra à qui
relit le transcript ensuite. Pour un dépôt partagé en équipe, c'est un point d'attention
réel : le comportement de l'agent dépend de quelque chose que la trace ne documente pas.

En revanche, ce que la voie *hooks* montre très bien, c'est **ce que votre propre
configuration coûte**. Sur la machine qui a servi à préparer ces exercices :
32 609 hooks, **un `PreToolUse` et un `PostToolUse` à chaque appel d'outil**, 41 ms de
médiane avant et 28 ms après. Un sous-agent, lui, n'en a qu'un seul : `SubagentStart`.

## Pour le vérifier vous-même

Relancez **sans** l'isolation, pour que vos hooks personnels se chargent aussi :

```sh
claude --strict-mcp-config --mcp-config .mcp.json
```

Les vôtres apparaîtront dans la voie *hooks*. Ceux de l'exercice, toujours pas.

## Terminer

```sh
./remise-a-zero.sh
```
