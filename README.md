# Windows Polish V1.0

Batch script para Windows 10/11 com o objetivo de aplicar ajustes de privacidade, desativar telemetria e remover serviços considerados supérfluos para o usuário doméstico.

> **AVISO IMPORTANTE:** Este script faz alterações profundas no sistema. Use por sua conta e risco. Sempre crie um ponto de restauração antes de executar.

## 📋 O que este script faz?

O Windows Polish organiza suas ações em quatro modos de execução, permitindo desde ajustes leves até uma configuração completa e silenciosa.

### Modos de Execução

| Modo | Descrição |
| :--- | :--- |
| **Suave** | Aplica apenas configurações de baixo risco, como desativar telemetria e ID de anúncio. |
| **Intermediário** | Inclui o modo Suave + serviços legados e ajustes de conteúdo em nuvem. |
| **Completo** | Executa **todas** as tarefas sem fazer perguntas. Assume "Sim" para todas as confirmações. |
| **Customizado** | Permite escolher tarefa por tarefa o que será executado. |

## ✅ Serviços que são (geralmente) seguros desativar

Esta lista reflete o que o script desativa e por quê. A maioria não afeta o uso diário do sistema para um usuário comum.

| Serviço | Nome Técnico | O que faz | Impacto |
| :--- | :--- | :--- | :--- |
| **Connected User Experiences and Telemetry** | `DiagTrack` | Coleta dados de diagnóstico e uso para a Microsoft. | Privacidade. Não quebra o sistema [citation:9]. |
| **Windows Error Reporting Service** | `WerSvc` | Envia relatórios de erro para a Microsoft após travamentos. | Você deixa de enviar relatórios. O sistema continua funcionando. |
| **SysMain (Superfetch)** | `SysMain` | Pré-carrega apps na RAM. | Em SSDs, o ganho é mínimo e pode causar alto uso de disco [citation:9]. |
| **Delivery Optimization** | `DoSvc` | Usa sua internet para compartilhamento P2P de atualizações. | Economiza banda. O Windows Update continua funcionando [citation:9]. |
| **Fax** | `Fax` | Envio e recebimento de fax. | Obsoleto para 99% dos usuários. |
| **Remote Registry** | `RemoteRegistry` | Permite que usuários remotos alterem o registro. | **Segurança.** É um risco desnecessário para uso doméstico. |
| **Serviços do Xbox** | `XblAuthManager`, etc. | Autenticação, saves e rede do Xbox Live. | Só desative se **não** usar Game Pass, Store ou controles Xbox. |

## ⚠️ O que PODE quebrar (e você deve saber)

Desativar serviços é uma faca de dois gumes. O que é "inútil" para um pode ser essencial para outro.

1.  **Microsoft Store e Xbox:** Se você desativar o grupo do Xbox, jogos da Store e o Game Pass podem parar de funcionar. O script pergunta antes de mexer na Store, mas o grupo do Xbox é desativado nos modos Intermediário e Completo.
2.  **Windows Search:** O script **não** desativa o `WSearch` por padrão no modo Completo porque isso torna a busca do Windows extremamente lenta. Se você usa muito a barra de pesquisa, não mexa nele.
3.  **Telefonia (`TapiSrv`):** Pode ser dependência de alguns softwares de VPN ou comunicação. Se notar problemas, reative-o com `sc config TapiSrv start= demand`.
4.  **Atualizações do Windows:** O script **não** desativa o Windows Update. Ele apenas configura para avisar antes de baixar. O `WaaSMedicSvc` (que repara o Windows Update) **nunca** deve ser desativado.

## 🛠️ Detalhes Técnicos

- **Requisito:** Executar como **Administrador**.
- **Compatibilidade:** Windows 10 e Windows 11.
- **Método:** O script usa `reg add` para aplicar as políticas diretamente no registro. Isso tem o mesmo efeito prático do Editor de Política de Grupo Local (`gpedit.msc`), mas as alterações **não aparecerão** na interface do `gpedit`.
- **Serviços inexistentes:** O script ignora serviços que não existem na versão do Windows em uso (ex: Copilot em versões antigas).

## 🚀 Como usar

1.  Baixe o arquivo `.bat`.
2.  Clique com o botão direito e escolha **"Executar como administrador"**.
3.  Escolha um dos modos no menu.
4.  Reinicie o computador ao final para garantir que tudo seja aplicado.

## 📜 Licença

Este projeto é de uso livre para fins pessoais. Não há garantias. Use por sua conta e risco.
