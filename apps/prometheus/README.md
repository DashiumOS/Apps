# Prometheus

Boîte à outils de monitoring et d'alerte de systèmes open source.

## Ports

- **9090**: Interface web et API HTTP (mappé vers 9090 sur l'hôte)

## Volumes

- **data**: `/prometheus` - Données de time series persistantes
- **config**: `/etc/prometheus` - Configuration (prometheus.yml)

## Ressources

- CPU: 1.0 core
- Mémoire: 512 MB

## Configuration

Le fichier `prometheus.yml` doit être fourni dans le volume `config`:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```

## Intégration

- **Grafana**: Visualisation des métriques
- **Alertmanager**: Gestion des alertes
- **Node Exporter**: Métriques système\n\n
