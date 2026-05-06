# Nginx

Serveur web haute performance et reverse proxy.

## Ports

- **80**: HTTP (mappé vers 8080 sur l'hôte)
- **443**: HTTPS (mappé vers 8443 sur l'hôte)

## Volumes

- **html**: `/usr/share/nginx/html` - Fichiers statiques
- **conf**: `/etc/nginx/conf.d` - Configuration additionnelle

## Ressources

- CPU: 0.5 core
- Mémoire: 128 MB
