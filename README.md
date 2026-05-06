# DashiumOS Apps Repository

Ce dépôt contient les intégrations d'applications pour DashiumOS.

## Structure

Chaque dossier représente une application avec:
- `config.yml` - Configuration de l'application pour DashiumOS
- `metadata.yml` - Métadonnées additionnelles (catégorie, tags, etc.)
- `README.md` - Documentation spécifique à l'app

## Format Manifest

```yaml
name: app-name
description: Description de l'application
version: 1.0.0
image: docker.io/library/app:latest
ports:
  80: 8080
environment:
  ENV_VAR: value
volumes:
  - name: data
    path: /data
resourceLimits:
  cpu: 0.5
  memory: 256
healthCheck:
  command:
    - CMD-SHELL
    - curl -f http://localhost/ || exit 1
  interval: 30
  timeout: 10
  retries: 3
  startPeriod: 40
```

## Ajouter une nouvelle app

1. Créer un dossier avec le nom de l'app
2. Ajouter `config.yml` avec la configuration (ou `.json`)
3. Ajouter `metadata.yml` (optionnel)
4. Ajouter `README.md` avec la documentation

## Installation

Les applications peuvent être installées via l'API DashiumOS en utilisant les fichiers `config.yml` fournis dans ce dépôt.

## Apps disponibles

- [Nginx](./nginx/) - Serveur web reverse proxy
- [PostgreSQL](./postgresql/) - Base de données relationnelle
- [Redis](./redis/) - Cache en mémoire
- [Nextcloud](./nextcloud/) - Stockage cloud
- [Grafana](./grafana/) - Visualisation de métriques
- [Prometheus](./prometheus/) - Monitoring
