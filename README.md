Windows Polish V1.0
Um script em lote (batch) para Windows 10/11 que aplica ajustes de privacidade, desativa telemetria e remove serviços desnecessários — do usuário comum ao entusiasta.

📌 Parte 1: O que é e para quem serve
O que o script faz (resumo)
O Windows Polish reúne, em um único menu interativo, dezenas de alterações que normalmente exigiriam navegar por dezenas de telas do Editor de Política de Grupo, do Registro e do services.msc. Ele foi pensado para três objetivos principais:

Reduzir a telemetria: bloquear o envio de dados de diagnóstico e uso para a Microsoft, que roda em segundo plano mesmo sem benefício direto ao usuário .

Desativar serviços supérfluos: remover da inicialização serviços como Fax, Xbox Live e Telefonia, que consomem recursos sem utilidade para a maioria dos usuários domésticos .

Ajustar comportamentos do sistema: impedir pré-carregamento do Edge, desativar ID de anúncio, limitar o Windows Update a "avisar antes de baixar", entre outros.

O que o script NÃO faz: ele não desativa o Windows Update, não mexe no Microsoft Defender, não remove o Microsoft Store (a menos que você escolha isso explicitamente) e não quebra a ativação do Windows.

As quatro opções de execução
Modo	Para quem é	O que faz
Suave	Qualquer pessoa que quer só um pouco mais de privacidade, sem risco.	Aplica apenas ajustes de baixo impacto: telemetria, ID de anúncio, histórico de documentos e serviços de IA (Copilot).
Intermediário	Usuários que querem um sistema mais limpo e não se importam em perder recursos que não usam.	Inclui o modo Suave + serviços legados (Fax, Registro Remoto), Xbox, Telefonia e ajustes de nuvem/Edge.
Completo	Entusiastas ou técnicos que querem o pacote inteiro, sem parar para responder perguntas.	Executa todas as tarefas, assumindo "Sim" para todas as confirmações. Inclui performance (SysMain, Windows Search) e Store.
Customizado	Quem quer controle total.	Pergunta tarefa por tarefa se deve executar ou pular.
Como isso ajuda no Windows 10/11
O Windows 10 e 11 vêm com dezenas de serviços e políticas ativadas por padrão que priorizam a coleta de dados e a integração com a nuvem da Microsoft — não necessariamente o desempenho ou a privacidade do usuário. O serviço DiagTrack, por exemplo, coleta dados de uso e pode causar picos de uso de disco em máquinas mais antigas . O SysMain, embora útil em HDDs, tem benefício marginal em SSDs e pode causar lentidão em alguns casos . O script permite que você decida o que manter.

Para todos os públicos: o modo Suave é seguro para qualquer usuário. O modo Intermediário é seguro para quem não usa Game Pass nem controle de Xbox. O modo Completo é para quem sabe o que está fazendo (ou quer descobrir). O modo Customizado é para quem quer aprender.

🛠️ Parte 2: Detalhes técnicos e lista completa de tarefas
Requisitos e comportamento técnico
Execução: obrigatoriamente como Administrador.

Compatibilidade: Windows 10 (1903+) e Windows 11 (21H2+).

Método de aplicação: as políticas são escritas diretamente no registro via reg add. Isso tem o mesmo efeito prático do gpedit.msc, mas não aparece na interface do Editor de Política de Grupo .

Serviços inexistentes: o script verifica a existência do serviço antes de tentar desativá-lo. Se o serviço não existir na sua versão do Windows (ex: Copilot em versões antigas), ele exibe um aviso e pula.

Reinício: ao final de cada modo, o script pergunta se deseja reiniciar. No modo Completo, o reinício é agendado automaticamente em 60 segundos.

Lista completa de tarefas
Abaixo estão todas as tarefas registradas no script, com o nome da sub-rotina, o que ela faz e em quais modos ela roda.

🔒 Privacidade e Telemetria
#	Sub-rotina	O que faz	Modos
1	TAREFA_CompressorMemoria	Executa Disable-MMAgent -mc via PowerShell para desativar o compressor de memória.	1, 2, 3
2	TAREFA_DadosDiagnostico	Define AllowTelemetry=0 em HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection. Bloqueia o envio de dados de diagnóstico .	1, 2, 3
3	TAREFA_CompatibilidadeApps	Desativa AITEnable, DisableEngine, DisablePCA, DisableInventory, DisableSwitchback e DisableUAR em AppCompat. Corta a telemetria de compatibilidade de aplicativos.	1, 2, 3
4	TAREFA_ConteudoNuvem	Desativa conteúdo otimizado em nuvem, experiências do consumidor, dicas do Windows e fixação do Copilot em CloudContent.	2, 3
5	TAREFA_ControleVoz	Define AllowSpeechModelUpdate=0 em Speech. Impede o envio de dados de fala para atualização de modelos.	2, 3
6	TAREFA_ExploradorArquivos	Define DisableGraphRecentItems=1 em Explorer. Remove os "insights baseados em conta" (arquivos recentes, favoritos) do Explorador.	2, 3
7	TAREFA_PushToInstall	Define DisablePushToInstall=1. Desativa o serviço de instalação remota de apps por push.	2, 3
8	TAREFA_LocalSensores	Define DisableLocation=1 em LocationAndSensors. Desativa o serviço de localização.	2, 3
9	TAREFA_LocalizadorWindows	Define DisableWindowsLocationProvider=1. Desativa o provedor de localização do Windows.	2, 3
10	TAREFA_Pesquisa	Desativa Cortana, pesquisa na nuvem, destaques, uso de localização e pesquisa na Web em Windows Search.	3
11	TAREFA_PrivacidadeApps	Define como "Forçar Negação" (valor 2) o acesso de apps a informações de conta, movimento, eye tracker, captura de tela, presença e execução em segundo plano.	3
12	TAREFA_IdAnuncio	Define DisabledByGroupPolicy=1 em AdvertisingInfo. Desliga a ID de anúncio.	1, 2, 3
13	TAREFA_PoliticasSO	Desativa sincronização de clipboard entre dispositivos, Feed de Atividades, publicação e upload de atividades do usuário.	2, 3
🕰️ Serviços Legados
#	Sub-rotina	O que faz	Modos
14	TAREFA_SvcLegados	Para e desabilita Fax, RemoteRegistry e seclogon (Secondary Logon). O RemoteRegistry é um risco de segurança conhecido .	2, 3
🎮 Serviços do Xbox
#	Sub-rotina	O que faz	Modos
15	TAREFA_SvcXbox	Para e desabilita XblAuthManager, XblGameSave, XboxNetApiSvc e XboxGipSvc. Só use se não joga Game Pass nem usa controle de Xbox.	2, 3
📞 Serviços de Telefonia
#	Sub-rotina	O que faz	Modos
16	TAREFA_SvcTelefonia	Para e desabilita TapiSrv, PhoneSvc, CellTime, CellularSvc e PhoneLineVoicemail. O TapiSrv pode ser dependência de algumas VPNs — reative se necessário.	2, 3
⚡ Performance
#	Sub-rotina	O que faz	Modos
17	TAREFA_SvcPerformance	Para e desabilita SysMain, WSearch e DoSvc. Atenção: WSearch desativado torna a busca do Windows muito lenta; SysMain tem benefício questionável em SSDs .	3
🤖 Inteligência Artificial
#	Sub-rotina	O que faz	Modos
18	TAREFA_SvcIA	Para e desabilita Copilot e WindowsAISvc, se existirem.	1, 2, 3
🌐 Microsoft Edge e Store
#	Sub-rotina	O que faz	Modos
19	TAREFA_MicrosoftEdge	Desativa AllowPrelaunch, StartupBoostEnabled e define TabPreloading=2. Impede o Edge de pré-carregar na inicialização e ao fechar .	3
20	TAREFA_MicrosoftStore	Pergunta S/N. Se Sim: RemoveWindowsStore=1 (desativa a Store). Se Não: AutoDownload=2 (só bloqueia downloads automáticos).	3
⚙️ Sistema e Update
#	Sub-rotina	O que faz	Modos
21	TAREFA_WindowsUpdate	Define AUOptions=2 (avisar antes de baixar) e UpdateNotificationLevel=2. Não desativa o Windows Update.	2, 3
22	TAREFA_MenuIniciar	Define NoRecentDocsHistory=1. Impede o menu Iniciar de manter histórico de documentos abertos recentemente.	1, 2, 3
23	TAREFA_RelatoriosErros	Pergunta S/N. Se Sim: desativa o Windows Error Reporting e o log de erros.	3
24	TAREFA_SincronizarConfig	Pergunta S/N. Se Sim: desativa a sincronização de configurações entre dispositivos via conta Microsoft.	3
🔄 Reboot
Tarefa	O que faz
TarefaReboot	Ao final de cada modo, pergunta se deseja reiniciar (10s de contagem). No modo Completo, agenda automaticamente em 60s com opção de cancelar via shutdown /a.
⚠️ O que pode quebrar (e como reverter)
Serviço/Política	Risco	Como reverter
Serviços do Xbox	Game Pass, saves na nuvem e controles de Xbox param de funcionar.	sc config XblAuthManager start= demand (repita para os outros).
WSearch (Windows Search)	Busca do Windows fica extremamente lenta.	sc config WSearch start= delayed-auto e reinicie.
TapiSrv (Telefonia)	Algumas VPNs ou softwares de comunicação podem falhar.	sc config TapiSrv start= demand.
SysMain	Em HDDs, os apps podem demorar mais para abrir.	sc config SysMain start= auto.
RemoteRegistry	Nenhum para uso doméstico. É um ganho de segurança.	sc config RemoteRegistry start= demand (não recomendado).
Store (RemoveWindowsStore)	Apps da Store e Game Pass deixam de funcionar.	reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /f.
🚀 Como usar
Baixe o arquivo WindowsPolish.bat.

Clique com o botão direito → Executar como administrador.

Escolha um dos quatro modos.

Ao final, reinicie o computador (o script oferece essa opção).

📜 Licença
Uso livre para fins pessoais. Sem garantias. Use por sua conta e risco.
