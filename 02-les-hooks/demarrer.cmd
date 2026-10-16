@echo off
rem Équivalent Windows (cmd, PowerShell, cmder) de demarrer.sh.
rem Lance Claude Code **isolé** : seuls les serveurs MCP et les réglages de cet exercice
rem sont chargés, comme avec demarrer.sh.
cd /d "%~dp0" || exit /b 1
claude --strict-mcp-config --mcp-config .mcp.json --setting-sources project %*
