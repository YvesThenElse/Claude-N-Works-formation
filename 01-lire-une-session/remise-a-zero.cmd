@echo off
rem Équivalent Windows (cmd, PowerShell, cmder) de remise-a-zero.sh.
rem Rend à l'exercice son état d'origine : tout ce qu'il a produit est non versionné.
cd /d "%~dp0" || exit /b 1
git clean -xdf . >nul 2>&1 || (echo hors d'un depot git : supprimez a la main ce que l'exercice a produit & exit /b 1)
echo exercice remis a neuf.
