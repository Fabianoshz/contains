# Testes

Como estamos criando um container com base no Arch Linux

```
sed -i 's/SigLevel    = Required DatabaseOptional/SigLevel    = Never/' /etc/pacman.conf
pacman -S --noconfirm nginx
```

Finalmente, vamos iniciar o nginx em background

```
nginx
```

No seu host você pode verificar que é possível chegar no container:

```
curl http://10.1.0.2
```

Próximo: [Importando container no docker](07-importando-container-no-docker.md)
