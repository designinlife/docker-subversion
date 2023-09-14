# Subversion for Docker (Alpine OS)

## Deployment configuration

`docker-compose.yml`

```yaml
version: "3"
services:

  svn:
    container_name: svn
    hostname: svn
    network_mode: bridge
    image: designinlife/subversion:1.1.0
    ports:
      - "3690:3690"
    volumes:
      - "/data/docker/var/svn:/var/svn"
      - "/etc/localtime:/etc/localtime:ro"
    environment:
      - TZ=UTC
    ulimits:
      nofile:
        soft: 65535
        hard: 65535
    restart: always
```

### Create an new repository

```bash
docker exec -i svn create [Your Project Name]
```
