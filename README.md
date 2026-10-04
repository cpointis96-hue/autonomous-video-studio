# Autonomous Video Studio

## En bref

**Ce que c’est :** une première version d’atelier local pour préparer un montage vidéo à partir de consignes et d’une timeline JSON.

**À quoi il sert :** formaliser les clips, timecodes, transitions et la provenance d’un futur rendu, puis vérifier qu’une chaîne FFmpeg fonctionne.

**Ce qui a été réalisé :** contrat de timeline, règles de travail de l’atelier et smoke test qui génère, inspecte, découpe, concatène et normalise un média synthétique.

**Technologies :** zsh, JSON Schema, FFmpeg, ffprobe et jq.

Le projet ne livre pas encore d’interface graphique, d’exécuteur de timeline, de transcription ou de montage automatique.

## Contenu

- `skills/video-studio/SKILL.md` : modes Director, recherche/B-roll et Editor, conservation des originaux et vérification des rendus.
- `tools/timeline.schema.json` : schéma JSON 2020-12 pour clips, timecodes, cadrage, transitions, audio et provenance.
- `scripts/smoke-test.sh` : génération synthétique, inspection ffprobe, découpage, concaténation et normalisation.
- `AGENTS.md` : règles du projet ; son renvoi historique à `SOUL.md` ne fournit pas ce fichier dans les sources actuelles.

## Lancer

Prérequis : zsh, FFmpeg/ffprobe et jq. Exemple macOS/Homebrew :

```sh
brew install ffmpeg jq
zsh scripts/smoke-test.sh
```

Le test génère 2 s de mire 320 × 180 à 24 images/s et une sinusoïde de 440 Hz. Il découpe 1 s, répète cette partie, normalise à −16 LUFS et vérifie les pistes/durées. Les fichiers temporaires sont nettoyés ; aucun rush personnel utilisé. Il ne teste pas Cap ni l’édition d’une timeline.

## Vérifié le 4 octobre 2026

Smoke test réussi sur macOS. Inspection distincte : l’ancien découpage `-c copy` produisait 1,125 s de vidéo pour 1 s demandée. La copie de publication réencode cette partie en H.264/AAC, contrôle sa durée entre 0,95 et 1,05 s, l’export entre 1,95 et 2,15 s et la présence de pistes audio/vidéo.

Ces résultats portent sur l’exécution et les métadonnées, pas une inspection perceptuelle du rendu. Aucune capture d’éditeur n’est inventée : le projet n’a pas d’interface propre.

## Reprendre

Créer `projects/<id>/` avec `source/`, `transcript/`, `research/`, `broll/`, `timeline/` et `renders/`. Référencer les sources/timecodes dans la timeline, sans modifier les originaux. Le schéma ne garantit pas `out > in`, l’existence des fichiers ou l’exécution des effets ; contrôles et moteur restent à implémenter.

Cap est une intégration envisagée par les consignes, pas un logiciel développé ici ni testé par le smoke test. Vérifier séparément installation, authentification et contrats disponibles. Les déclarations de l’ancienne notice sur la machine d’origine ne prouvent pas que ces prérequis sont satisfaits chez le lecteur.

V1 attend une validation explicite. Suite : exemple de timeline validé, contrôles sémantiques, puis moteur limité aux opérations prises en charge et inspection des exports. La préparation du portfolio n’a pas démarré V1 ; les consignes locales limitent ce travail à la vérification de V0.

## Distribution

Workflow CLI, sans binaire ni service web. Rushs, projets privés et exports personnels exclus de cette copie. Cette copie de publication démarre un nouvel historique Git : l’historique local contient une référence de persona privée supprimée du checkout actuel et n’est pas importé. Le dépôt original et ses dates ne sont pas modifiés.

## Dépôt et téléchargement

[Voir le dépôt](https://github.com/cpointis96-hue/autonomous-video-studio) · [Télécharger les sources ZIP](https://github.com/cpointis96-hue/autonomous-video-studio/archive/HEAD.zip). Le ZIP contient le workflow et ses scripts, sans application installable.
