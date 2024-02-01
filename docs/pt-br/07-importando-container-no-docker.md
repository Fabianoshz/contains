# Importando container no docker

## O que é uma imagem Docker

## Docker import

```
cd system-root && sudo tar -czf ../system-root.tar.gz .
cat ../system-root.tar.gz | docker import - contains:latest
```

## Docker run

```
docker run -d --rm -it --name contains -p 80:80 contains nginx -g 'daemon off;'
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' contains
```