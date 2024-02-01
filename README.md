# Contains

Esse tutorial é um guia de como se criar um container do zero, sem utilizar nenhuma ferramenta como Podman, Docker, Buildah ou LXC. Nenhum container criado seguindo este tutorial deve ser considerado ideal para ambientes produtivos, se você quiser ter um container confiável utilize uma das ferramentas citadas anteriormente, a ideia desse texto é te mostrar como os conceitos funcionam por "debaixo do capô" das ferramentas de mercado.

## Público alvo

O público alvo desse tutorial são pessoas que tenham um conhecimento razoável de linux e containers, algumas terminologias como "CPU", "filesystem", "processos", "root" e outros do meio precisam ser comuns. Não obstante você pode usar esse tutorial como base para outros estudos que são usados aqui. Os resultados são em boa medida deterministicos, o que significa que dado o mesmo ambiente você terá sempre o mesmo resultado.

## Como colaborar

Encontrou algum erro ou tem sugestões? Abra uma [issue](https://github.com/Fabianoshz/contains/issues) ou [PR](https://github.com/Fabianoshz/contains/pulls).

## Ferramentas

Utilizaremos as seguinte ferramentas para criar o nosso container:
- Linux
- Namespaces
- Cgroups
- Unshare
- Iptables
- Nginx (para testar o container)

** Por fim importaremos o container para o Docker como uma imagem.
