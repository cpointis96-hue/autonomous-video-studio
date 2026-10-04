---
name: video-studio
description: Plan, research, edit, render, and verify local video projects in this repository using Cap, FFmpeg, ffprobe, and Playwright CLI.
---

# Video Studio

Ce skill est local à `Movies Maker`. Il s'applique aux demandes de production ou de montage vidéo dans ce dépôt.

## Modes

- **Director**: comprendre le brief, inspecter les rushs et le transcript, choisir la narration, les cuts, les zooms et les B-roll, puis écrire une timeline justifiée.
- **Research/B-roll**: utiliser Playwright CLI pour montrer la vraie source web, attendre sa stabilité, capturer un élément ou une courte séquence, et enregistrer URL, date, cadrage et usage dans `research/`.
- **Editor**: exécuter la timeline validée avec Cap ou FFmpeg, normaliser l'audio, produire les sous-titres demandés, exporter et contrôler le rendu avec ffprobe.

## Règles non négociables

- Les sources originales sont immuables. Aucun déplacement, écrasement ou suppression.
- Lire `ffprobe` avant tout traitement et écrire les dérivés dans `temp/`, `projects/<id>/` ou `output/`.
- La timeline JSON est la source de vérité. Respecter `tools/timeline.schema.json`.
- Les effets servent la compréhension. Aucun zoom, crop ou transition mécanique.
- Une capture web doit montrer la vraie page quand elle est accessible, avec sa provenance.
- Ne pas inventer de contenu, d'URL, de métadonnée ou de résultat de test.
- Ne pas installer de dépendance cloud ou payante sans accord explicite.
- Ne pas lancer V1 tant que l'utilisateur n'a pas explicitement validé son démarrage.

## Routage des outils

1. Utiliser Cap CLI ou son MCP pour ses fonctions réellement exposées: capture, projets `.cap`, export, bibliothèque et transcriptions. Découvrir le contrat avec `cap guide --json` et `cap <commande> --help`.
2. Utiliser `ffprobe` pour les métadonnées et FFmpeg pour les opérations déterministes de montage.
3. Utiliser `playwright-cli` pour les captures web et les séquences B-roll. Utiliser une session dédiée au projet et fermer la session après usage.
4. Utiliser les outils macOS uniquement si leur comportement est vérifié et apporte une capacité locale nécessaire.

## Validation

Séparer dans le compte rendu: commande exécutée, fichier produit, métadonnées observées, inspection réelle du rendu et éléments non testés. Une commande réussie ne prouve pas la qualité visuelle.
