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
| `PreToolUse` sur `Bash` et `PowerShell` | écrit la commande dans `journal-des-hooks.txt` et **attend 150 ms** |
| `PreToolUse` sur `Bash` et `PowerShell` | **refuse** toute commande contenant `plat-renvoye` |
| `PostToolUse` sur `Bash` et `PowerShell` | écrit `APRÈS` dans le journal |

Le second est un **chef de rang qui goûte le plat avant l'envoi**. Il refuse en écrivant
sur sa sortie standard :

```json
{"hookSpecificOutput":{"hookEventName":"PreToolUse",
  "permissionDecision":"deny","permissionDecisionReason":"…"}}
```

> **Pourquoi aussi `PowerShell` ?** Sous Windows, l'agent lance volontiers ses commandes
> avec l'outil `PowerShell` plutôt qu'avec `Bash`. Un hook ne voit que les outils que nomme
> son `matcher` : avec `"matcher": "Bash"` seul, `echo plat-renvoye` passait par PowerShell
> **sans être goûté** — constaté lors d'un essai sous Windows. D'où `"Bash|PowerShell"`.
> La leçon vaut au-delà de l'exercice : un hook de garde écrit pour un outil ne couvre pas
> la même commande lancée par un autre.

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

## Regarder — ③ ce qui RESTE visible : l'effet

Le hook n'a pas de trace, mais **son effet en a une**. Gardez la voie *outils* et cliquez
l'appel refusé — celui dont la bande de durée est **creuse**.

La carte dit :

| | |
|---|---|
| **Issue** | REFUSÉ — l'outil n'a pas tourné |
| **Refus** | refusé par une règle de permission |
| **Raison donnée** | Le chef de rang a goûté : ce plat ne part pas en salle. |

La raison est celle de votre hook, mot pour mot. Et la bande creuse est le point à retenir
visuellement : un appel **refusé** n'est pas un appel qui **échoue**. L'échec veut dire que
l'outil a tourné et mal fini ; le refus veut dire qu'il n'a pas tourné du tout — ce que le
journal disait déjà par l'`APRÈS` manquant.

**L'observateur s'arrête là où la trace s'arrête.** Il écrit « refusé par une règle de
permission », pas « refusé par un hook » — parce que la trace ne le dit pas : un refus de
hook et un refus de règle portent le même `toolDenialKind`, et aucun champ ne les sépare.
Ce qui les sépare est la raison. Une règle de Claude Code rend toujours la même phrase,
« *Permission to use Bash has been denied…* » ; votre hook rend la sienne. La carte le
signale sans l'affirmer :

> la raison n'est pas celle que rend une règle de Claude Code : elle a été fournie par ce
> qui a refusé — un hook, en pratique. La trace ne nomme pas son auteur.

C'est la bonne manière de lire un outil d'observation : il ne doit pas deviner à votre place.

## Ce qu'il faut en retenir

Un hook de projet **agit sans laisser de trace** — mais son **effet**, lui, en laisse une.
Le hook peut refuser une commande, en modifier l'entrée, injecter du texte dans la
conversation ; de tout cela, seul ce qui change le cours des choses apparaîtra à qui relit
le transcript ensuite, et jamais sous le nom de son auteur. Pour un dépôt partagé en équipe, c'est un point d'attention
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
