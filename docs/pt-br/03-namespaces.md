# Containers finalmente

## Namespaces

Sabendo que uma jail isola o filesystem mas não isola os recursos, nosso primeiro passo para criarmos o nosso container é isolar o acesso aos recursos do host, para isso usaremos o `unshare` que irá criar novos namespaces para o nosso processo:

Rode esse comando no host:

```
sudo unshare --mount --mount-proc --uts --ipc --net --pid --cgroup --time --fork --root=system-root bin/bash
```

Diferente da jail que criamos anteriormente o nosso novo processo não tem acesso aos recursos do namespace default da sessão do host, o que significa que se tentarmos verificar os processos do host rodando a partir do processo isolado não conseguiremos ver nenhum recurso do host:

```
ps ax -o pid,ppid,pidns,cmd --forest
```

O mesmo vale para as interfaces de rede (ou qualquer outro recurso):

```
ip link
```

Nosso container não tem nenhum mount configurado, então vamos criar o mount da raiz do sistema:

```
mount --bind / / && rm -rf /etc/mtab && ln -s /proc/mounts /etc/mtab
```

Mantenha o este terminal aberto pois a partir de agora usaremos ele para o container e outro para o host.

Próximo: [Entendendo jail](04-cgroups.md)
