# Grafana

Plateforme d'analyse et de visualisation interactive open source.

## Ports

- **3000**: Interface web (mappé vers 3000 sur l'hôte)

## Variables d'environnement

- `GF_SECURITY_ADMIN_USER`: Admin username (défaut: admin)
- `GF_SECURITY_ADMIN_PASSWORD`: Admin password (défaut: changeme)
- `GF_SERVER_ROOT_URL`: URL racine du serveur (défaut: http://localhost:3000)

## Volumes

- **data**: `/var/lib/grafana` - Données persistantes
- **provisioning**: `/etc/grafana/provisioning` - Configuration automatique

## Ressources

- CPU: 0.5 core
- Mémoire: 256 MB

## Sécurité

**Important**: Changez le mot de passe admin avant utilisation en production.

## Dépendances

Pour la visualisation de données, vous aurez besoin de:
- Prometheus (pour le scraping de métriques)
- Loki (pour les logs)
- Tempo (pour le tracing)
