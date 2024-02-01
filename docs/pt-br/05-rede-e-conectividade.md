# Rede e conectividade

## Conectividade limitada

Com nosso container isolado do host e com recursos limitados nós garantimos a estabilidade do sistema, no entanto nós precisamos conectar o nosso container a internet de alguma pois por termos criado um novo namespace de rede com `--net` nosso container não tem acesso a interface de rede do host.

## Interfaces virtuais

Para fornecer conexão nós podemos conectar o nosso container ao host através de interfaces virtuais, dessa forma podemos criar uma conexão entre os dois mas sem expor pacotes do host para o container e vice versa. Crie uma interface virtual no host:

```
sudo ip link add name host type veth peer name container
```

Interfaces virtuais são criadas em pares, aonde cada "ponta" da interface manda as conexões diretamente para a outra (independente do namespace em que elas estão). Verifique que você tem 2 interfaces virtuais (`container@host` e `host@container`):

```
ip link show type veth
```

Agora iremos enviar uma das pontas para o namespace do processo do nosso container, primeiro encontre o ID do processo que está rodando no nosso container:

```
ps ax -o pid,ppid,pidns,cmd --forest
```

Envie uma das pontas da interface virutal para o container:

```
sudo ip link set container netns <pid>
```

Interfaces virtuais são criadas desativadas, portanto vamos ativar a interface do lado do host:

```
sudo ip link set host up
sudo ip add add 10.1.0.1/24 dev host
```

Do lado do container precisamos fazer a mesma coisa, além disso adicionaremos uma rota default para o container e um registro `nameserver` para resolução de nomes:

```
ip link set container up
ip add add 10.1.0.2/24 dev container
ip route add default via 10.1.0.1
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
```

Por fim precisamos criar uma rota e permitir o forward de pacotes no host:

```
sudo sysctl net.ipv4.conf.all.forwarding=1 

sudo iptables -t nat -A POSTROUTING -s 10.1.0.0/24 -o <nome-da-sua-interface-de-rede> -j MASQUERADE
sudo iptables -A FORWARD -o <nome-da-sua-interface-de-rede> -i host -j ACCEPT
sudo iptables -A FORWARD -i <nome-da-sua-interface-de-rede> -o host -j ACCEPT
```

Próximo: [Testes](06-tests.md)
