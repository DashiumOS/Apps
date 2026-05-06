# PostgreSQL

Base de données relationnelle avancée open source.

## Ports

- **5432**: PostgreSQL (mappé vers 5432 sur l'hôte)

## Variables d'environnement

- `POSTGRES_USER`: Nom d'utilisateur (défaut: postgres)
- `POSTGRES_PASSWORD`: Mot de passe (défaut: changeme)
- `POSTGRES_DB`: Nom de la base de données (défaut: postgres)

## Volumes

- **data**: `/var/lib/postgresql/data` - Données persistantes

## Ressources

- CPU: 1.0 core
- Mémoire: 512 MB

## Sécurité

**Important**: Changez le mot de passe par défaut avant utilisation en production.
