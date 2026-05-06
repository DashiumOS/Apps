# Portainer

Plateforme de gestion de conteneurs pour Docker et Kubernetes.

## Ports

- **9443**: Interface web HTTPS (mappé vers 9443 sur l'hôte)
- **8000**: Edge agent (mappé vers 8000 sur l'hôte)

## Volumes

- **data**: `/data` - Données persistantes de Portainer
- **docker**: `/var/run/docker.sock` - Socket Docker (accès complet à Docker)

## Ressources

- CPU: 0.5 core
- Mémoire: 256 MB

## Sécurité

**Important**: 
- L'accès au socket Docker donne un contrôle complet sur les conteneurs
- Utilisez HTTPS en production (port 9443)
- Configurez l'authentification forte

## Premier démarrage

1. Accédez à `https://localhost:9443`
2. Définissez le mot de passe admin
3. Connectez-vous à l'environnement Docker
