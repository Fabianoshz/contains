# Criando uma jail

## Arquivos iniciais

Para iniciarmos a nossa criação nós precisaremos das dependências do sistema operacional, pois por mais que um container utilize os recursos e o kernel do host os arquivos do sistema operacional em si ainda são necessários assim como as dependências da própria aplicação (como libs, interpretadores e outras aplicações).

Existem diversas ferramentas que podemos usar para baixar os arquivos, vou deixar aqui dois exemplos:

Se você utiliza Arch Linux podemos conseguir os arquivos necessários usando o `pacstrap`:
```
sudo mkdir system-root && sudo pacstrap system-root base base-devel
```

Você se você utiliza Debian (ou derivados) pode usar debootstrap:
```
sudo mkdir system-root && debootstrap stable system-root http://deb.debian.org/debian/
```

Se você está em dúvida use o `debootstrap` mesmo que você esteja em outro sistema que não seja derivado do Debian.

Depois de rodar o comando você terá alguns arquivos dentro da pasta `system-root`, ela será a raiz do nosso container.

## Entrando na jail

Para entender um pouco melhor os conceitos você pode criar uma jail para a sua shell, isto é, alterar o ponto raiz de forma que os processos dentro dessa jail não poderão ver os arquivos acima na estrutura de diretórios, altere a raiz com o comando abaixo:

```
sudo chroot system-root /bin/bash
```

Você perceberá que a sua sessão mudará e você pode verificar que a estrutura de pastas mudou:

```
echo "Diretório atual:" $(pwd) && echo "Usuário:" $(whoami)
```

Se você usa um sistema que não segue o FHS (como NixOS) provavelmente nenhum comando irá funcionar, você pode resolver isso temporariamente rodando:

```
export PATH=/bin
```

Se isso não faz sentido pra você provavelmente estará seguro em ignorar.

## Isolamento

Uma jail ainda não é um container, por mais que ela seja o suficiente para a estrutura de pastas todos os outros recursos do host ainda são acessíveis de dentro dela, você pode verificar que a jail tem acesso a interface de rede da máquina por exemplo:

```
ip link
```

Ou mesmo que a jail pode ver os processos do host:

```
mount -t proc none /proc
ps ax -o pid,ppid,pidns,cmd --forest
umount /proc
```

Ou recursos da máquina:

```
free -m
```

Por mais que dentro de uma jail um processo não tenha como alterar arquivos de outras jails ou do host, por ter acesso aos recursos do host uma jail ainda pode afetar outros processos, consumindo toda banda de rede das interfaces, usando todo I/O de disco ou mesmo usando todo poder computacional ou espaço em memória.

Próximo: [Entendendo jail](03-namespaces.md)
