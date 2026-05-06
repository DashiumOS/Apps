# Nextcloud

Plateforme de stockage cloud et de collaboration.

## Ports

- **80**: HTTP (mappé vers 8080 sur l'hôte)

## Variables d'environnement

- `NEXTCLOUD_ADMIN_USER`: Admin username (défaut: admin)
- `NEXTCLOUD_ADMIN_PASSWORD`: Admin password (défaut: changeme)
- `NEXTCLOUD_TRUSTED_DOMAINS`: Domaines de confiance (défaut: localhost)

## Volumes

- **data**: `/var/www/html` - Données de l'application

## Ressources

- CPU: 1.0 core
- Mémoire: 512 MB

## Sécurité

**Important**: 
- Changez le mot de passe admin avant utilisation en production
- Configurez HTTPS pour un environnement de production
- Ajoutez vos domaines à `NEXTCLOUD_TRUSTED_DOMAINS`

## Dépendances

Pour une installation complète, vous aurez besoin de:
- Base de données (PostgreSQL ou MySQL)
- Redis (recommandé pour le cache)
