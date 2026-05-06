# GitLab

Plateforme DevOps complète (Git, CI/CD, registry, etc.).

## Ports

- **80**: HTTP (mappé vers 8080 sur l'hôte)
- **443**: HTTPS (mappé vers 8443 sur l'hôte)
- **22**: SSH (mappé vers 2222 sur l'hôte)

## Variables d'environnement

- `GITLAB_OMNIBUS_CONFIG`: Configuration omnibus GitLab

## Volumes

- **config**: `/etc/gitlab` - Configuration
- **logs**: `/var/log/gitlab` - Logs
- **data**: `/var/opt/gitlab` - Données (repositories, DB, etc.)

## Ressources

- CPU: 2.0 cores (minimum recommandé)
- Mémoire: 2048 MB (minimum recommandé)

## Configuration

GitLab nécessite au moins 4GB de RAM pour fonctionner correctement. Pour une utilisation en production, 8GB+ sont recommandés.

## Premier démarrage

1. Accédez à `http://localhost:8080`
2. Définissez le mot de passe root
3. Connectez-vous avec l'utilisateur `root`
