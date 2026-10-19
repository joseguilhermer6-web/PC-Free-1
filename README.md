# PC-Free no Codespaces — Windows 10

[**Abrir meu PC no Codespaces**](https://codespaces.new/joseguilhermer6-web/PC-Free-1)

## Começar

1. Abra o link acima e crie o Codespace na branch **main**, usando a configuração **PC-Free — Windows 10**.
2. Aguarde a criação do ambiente. A imagem atual do Dockur será baixada e iniciará o download e a instalação do Windows.
3. Abra a aba **Portas / Ports** e clique no endereço da porta **8006**. Mantenha a visibilidade **Private / Privada** e entre com a mesma conta do GitHub.
4. Aguarde o instalador terminar. Não há prazo garantido: o primeiro download pode levar bastante tempo.

A instalação é automática. Se precisar das credenciais, o usuário é `Jose` e a senha aleatória está no arquivo local `.env`, no campo `PASSWORD`. Nunca publique esse arquivo.

## Já tenho um Codespace antigo

Salve suas alterações locais e faça backup dos arquivos importantes antes de reconstruir. No terminal do Codespace antigo, na pasta deste repositório:

```bash
git pull --ff-only origin main
```

Depois, pressione **F1** e execute **Codespaces: Rebuild Container**. Quando voltar, abra a porta **8006**.

Se houver alterações locais ou conflito no Git, não use comandos de reset: preserve seus arquivos primeiro. Instalações antigas em volumes Docker não são migradas automaticamente. Prefira um Codespace novo para experimentar esta configuração sem alterar o antigo.

## O que foi corrigido

- Agora existem arquivos executáveis de configuração; antes havia apenas páginas e instruções.
- O disco fica no caminho correto, `/storage`, usando a pasta local `windows`.
- RAM e CPU se ajustam ao host, seguindo o exemplo oficial do Dockur para Codespaces.
- A imagem é atualizada ao iniciar pelo Compose, e o contêiner tem servidores DNS explícitos.
- Senha gerada localmente e porta web privada; nenhuma exigência de seguir uma conta.
- Não é necessário modificar `/etc/docker/daemon.json` nem apagar dados do Docker.

## Se aparecer um erro

**Faltam `/dev/kvm` ou `/dev/net/tun`:** o host não oferece os dispositivos necessários. Alterar DNS não resolve. A configuração verifica isso antes de iniciar. Não há garantia de que todo host do Codespaces permita virtualização.

**Could not resolve host / download falhou:** esta configuração usa a imagem atual e DNS explícito, mas isso não garante disponibilidade dos servidores da Microsoft. Copie a mensagem completa apresentada na porta 8006 ou no log de criação. Não fixe IPs de servidores Microsoft.

**Pouco espaço:** não apague seu disco ou volumes para tentar resolver. Faça backup antes de qualquer limpeza. O disco usa o ajuste automático do exemplo oficial, mas continua limitado pelo espaço do Codespace.

**Porta não abre:** confirme que o ambiente terminou de iniciar, que a porta 8006 está encaminhada e que você está na conta GitHub correta. Ela não precisa ser pública.

## Dados e limites

O Windows fica em `windows/` e não entra no Git. Reiniciar o mesmo Codespace mantém esses arquivos; excluir o Codespace também exclui os dados locais. Faça backup fora dele. A cota de computação e armazenamento depende da sua conta; isso não é um servidor gratuito permanente. Use uma licença Windows apropriada.

## Referências

- [Configuração oficial do Dockur para Codespaces](https://github.com/dockur/windows/tree/master/.devcontainer)
- [Documentação do Dockur](https://github.com/dockur/windows)
- [Portas no Codespaces](https://docs.github.com/pt/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace)
- [Tutorial original preservado, com instruções antigas](README-original.md)
