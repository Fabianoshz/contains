# Introdução

## O que é um container

Um container é uma forma de isolar um processo com determinados recursos do host, isso se da através do uso de **namespaces** e **cgroups** que são respectivamente formas de isolamento e limitação dentro dos subsistemas do linux. Sem essas 2 tecnologias seria impossível se ter containers como temos atualmente e com um bom entendimento delas você será capaz de entender muito melhor como sistemas sistemas distribuídos que usam containers funcionam e como otimizar e resolver problemas.

## O que são cgroups

Usando Cgroups ou (control groups) podemos limitar a quantidade de recursos dentro de um subsistema do linux, como CPU, memória, IO e rede. Para exemplificar um cgroup que tenha um limite de 512MB de memória por exemplo irá terminar processos que estejam em seu namespace (usando o OOM) caso seu limite seja ultrapassado (faremos isso na prática).

## O que são namespaces

Namespaces lidam com segregação, cada subsistema do linux lida com a segreção dos recursos que gerencia, o subsistema de filesystem por exemplo lidará com a segregação de volumes de um determinado container. Se você quiser ler mais sobre namespaces o melhor lugar é o [manual do próprio linux](https://man7.org/linux/man-pages/man7/namespaces.7.html).

Você pode ver os namespaces de qualquer processo na sua máquina facilmente observando o resultado da estrutura de diretório `/proc/<pid>/ns/` como no exemplo abaixo:

```
> sudo ls -ltrh /proc/1/ns/
total 0
lrwxrwxrwx 1 root root 0 jul 24 11:44 cgroup -> 'cgroup:[4026531835]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 uts -> 'uts:[4026531838]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 user -> 'user:[4026531837]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 time_for_children -> 'time:[4026531834]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 time -> 'time:[4026531834]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 pid_for_children -> 'pid:[4026531836]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 pid -> 'pid:[4026531836]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 net -> 'net:[4026532000]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 mnt -> 'mnt:[4026531840]'
lrwxrwxrwx 1 root root 0 jul 24 18:44 ipc -> 'ipc:[4026531839]'
```

Próximo: [Arquivos iniciais](02-criando-uma-jail.md)
