@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title WindowsPolishV1

REM ============================================================================
REM  WINDOWS POLISH V 1.0 - WINDOWS 10/11
REM  ----------------------------------------------------------------------------
REM  Requer execução como Administrador.
REM  Modos: Suave / Intermediário / Completo / Customizado
REM
REM  IMPORTANTE:
REM    - Modo "Completo" é SILENCIOSO: não faz nenhuma pergunta.
REM      Todas as decisões S/N são assumidas como "S".
REM    - Modo "Customizado" continua perguntando tudo normalmente.
REM
REM  COMO ADICIONAR TAREFA:
REM    1) Criar sub-rotina :TAREFA_NomeDela
REM    2) Registrar em :RegistrarTarefas (LABEL, DESC, MODOS)
REM    3) Incrementar TAREFA_TOTAL
REM ============================================================================


REM ----------------------------------------------------------------------------
REM  VERIFICAÇÃO DE PRIVILÉGIOS
REM ----------------------------------------------------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Este script precisa ser executado como Administrador.
    echo        Clique com o botao direito ^> Executar como administrador.
    echo.
    pause
    exit /b 1
)


call :RegistrarTarefas
goto :MenuPrincipal


REM ============================================================================
REM  MENU PRINCIPAL
REM ============================================================================
:MenuPrincipal
    cls
    echo ============================================================
    echo             ASSISTENTE DE MANUTENÇÃO - WINDOWS
    echo ============================================================
    echo.
    echo   [1] Suave          - Tarefas leves, sem impacto
    echo   [2] Intermediário  - Limpezas e ajustes moderados
    echo   [3] Completo       - Manutenção completa, SEM perguntas
    echo   [4] Customizado    - Escolher tarefas individualmente
    echo   [0] Sair
    echo.
    set "OPCAO="
    set /p "OPCAO=Escolha uma opção: "

    if "!OPCAO!"=="1" call :ExecutarModo 1
    if "!OPCAO!"=="2" call :ExecutarModo 2
    if "!OPCAO!"=="3" call :ExecutarModo 3
    if "!OPCAO!"=="4" call :ModoCustomizado
    if "!OPCAO!"=="0" goto :Sair
    goto :MenuPrincipal


REM ============================================================================
REM  REGISTRO DE TAREFAS
REM ============================================================================
:RegistrarTarefas
    set "TAREFA_TOTAL=25"

    REM ============ POLÍTICAS DE GRUPO / REGEDIT ============

    REM ----- Item 0 -----
    set "TAREFA_1_LABEL=TAREFA_CompressorMemoria"
    set "TAREFA_1_DESC=Desativar compressor de memória (Disable-MMAgent -mc)"
    set "TAREFA_1_MODOS=1 2 3"

    REM ----- Item 1 -----
    set "TAREFA_2_LABEL=TAREFA_DadosDiagnostico"
    set "TAREFA_2_DESC=Desativar Dados de Diagnóstico (Telemetria)"
    set "TAREFA_2_MODOS=1 2 3"

    REM ----- Item 2 -----
    set "TAREFA_3_LABEL=TAREFA_CompatibilidadeApps"
    set "TAREFA_3_DESC=Desativar Telemetria e Compatibilidade de Aplicativos"
    set "TAREFA_3_MODOS=1 2 3"

    REM ----- Item 3 -----
    set "TAREFA_4_LABEL=TAREFA_ConteudoNuvem"
    set "TAREFA_4_DESC=Desativar Conteúdo de Nuvem e experiências do consumidor"
    set "TAREFA_4_MODOS=2 3"

    REM ----- Item 4 -----
    set "TAREFA_5_LABEL=TAREFA_ControleVoz"
    set "TAREFA_5_DESC=Desativar Atualização Automática de Dados de Fala"
    set "TAREFA_5_MODOS=2 3"

    REM ----- Item 5 -----
    set "TAREFA_6_LABEL=TAREFA_ExploradorArquivos"
    set "TAREFA_6_DESC=Desativar insights baseados em conta no Explorador"
    set "TAREFA_6_MODOS=2 3"

    REM ----- Item 6 -----
    set "TAREFA_7_LABEL=TAREFA_PushToInstall"
    set "TAREFA_7_DESC=Desativar Serviço de Instalação por Push"
    set "TAREFA_7_MODOS=2 3"

    REM ----- Item 7 -----
    set "TAREFA_8_LABEL=TAREFA_LocalSensores"
    set "TAREFA_8_DESC=Desativar Local (sensores)"
    set "TAREFA_8_MODOS=2 3"

    REM ----- Item 8 -----
    set "TAREFA_9_LABEL=TAREFA_LocalizadorWindows"
    set "TAREFA_9_DESC=Desativar Fornecedor de Local do Windows"
    set "TAREFA_9_MODOS=2 3"

    REM ----- Item 9 -----
    set "TAREFA_10_LABEL=TAREFA_MicrosoftStore"
    set "TAREFA_10_DESC=Microsoft Store (pergunta S/N)"
    set "TAREFA_10_MODOS=3"

    REM ----- Item 10 -----
    set "TAREFA_11_LABEL=TAREFA_MicrosoftEdge"
    set "TAREFA_11_DESC=Desativar pré-carregamento e startup boost do Edge"
    set "TAREFA_11_MODOS=3"

    REM ----- Item 11 -----
    set "TAREFA_12_LABEL=TAREFA_Pesquisa"
    set "TAREFA_12_DESC=Desativar Cortana, pesquisa na nuvem e web"
    set "TAREFA_12_MODOS=3"

    REM ----- Item 12 -----
    set "TAREFA_13_LABEL=TAREFA_PrivacidadeApps"
    set "TAREFA_13_DESC=Restringir privacidade de aplicativos (Forçar Negação)"
    set "TAREFA_13_MODOS=3"

    REM ----- Item 13 -----
    set "TAREFA_14_LABEL=TAREFA_RelatoriosErros"
    set "TAREFA_14_DESC=Relatórios de Erros do Windows (pergunta S/N)"
    set "TAREFA_14_MODOS=3"

    REM ----- Item 14 -----
    set "TAREFA_15_LABEL=TAREFA_SincronizarConfig"
    set "TAREFA_15_DESC=Sincronizar suas configurações (pergunta S/N)"
    set "TAREFA_15_MODOS=3"

    REM ----- Item 15 -----
    set "TAREFA_16_LABEL=TAREFA_WindowsUpdate"
    set "TAREFA_16_DESC=Configurar Windows Update (avisar antes de baixar)"
    set "TAREFA_16_MODOS=2 3"

    REM ----- Item 16 -----
    set "TAREFA_17_LABEL=TAREFA_MenuIniciar"
    set "TAREFA_17_DESC=Não manter histórico de documentos recentes"
    set "TAREFA_17_MODOS=1 2 3"

    REM ----- Item 17 -----
    set "TAREFA_18_LABEL=TAREFA_IdAnuncio"
    set "TAREFA_18_DESC=Desligar a ID de anúncio"
    set "TAREFA_18_MODOS=1 2 3"

    REM ----- Item 18 -----
    set "TAREFA_19_LABEL=TAREFA_PoliticasSO"
    set "TAREFA_19_DESC=Desativar sincronização de clipboard e Feed de Atividades"
    set "TAREFA_19_MODOS=2 3"

    REM ============ SERVIÇOS ============

    REM ----- Grupo A -----
    set "TAREFA_20_LABEL=TAREFA_SvcTelemetria"
    set "TAREFA_20_DESC=[Serviços] Telemetria e Privacidade (DiagTrack, DPS, WerSvc...)"
    set "TAREFA_20_MODOS=1 2 3"

    REM ----- Grupo B -----
    set "TAREFA_21_LABEL=TAREFA_SvcLegados"
    set "TAREFA_21_DESC=[Serviços] Legados (Fax, RemoteRegistry, Secondary Logon)"
    set "TAREFA_21_MODOS=2 3"

    REM ----- Grupo C -----
    set "TAREFA_22_LABEL=TAREFA_SvcXbox"
    set "TAREFA_22_DESC=[Serviços] Xbox (Auth, GameSave, NetApi, GipSvc)"
    set "TAREFA_22_MODOS=2 3"

    REM ----- Grupo D -----
    set "TAREFA_23_LABEL=TAREFA_SvcTelefonia"
    set "TAREFA_23_DESC=[Serviços] Telefonia (TapiSrv, PhoneSvc, CellTime...)"
    set "TAREFA_23_MODOS=2 3"

    REM ----- Grupo E -----
    set "TAREFA_24_LABEL=TAREFA_SvcPerformance"
    set "TAREFA_24_DESC=[Serviços] Performance (SysMain, Windows Search, Delivery Optimization)"
    set "TAREFA_24_MODOS=3"

    REM ----- Grupo F -----
    set "TAREFA_25_LABEL=TAREFA_SvcIA"
    set "TAREFA_25_DESC=[Serviços] IA (Copilot, Windows AI Service)"
    set "TAREFA_25_MODOS=1 2 3"

goto :eof


REM ============================================================================
REM  MOTOR DE EXECUÇÃO DOS MODOS 1, 2 e 3
REM ============================================================================
:ExecutarModo
    set "MODO_ATUAL=%~1"
    set "MODO_SILENCIOSO=0"
    if "%MODO_ATUAL%"=="3" set "MODO_SILENCIOSO=1"

    cls
    echo ============================================================
    echo   Executando modo:
    if "%MODO_ATUAL%"=="1" echo     ^> SUAVE
    if "%MODO_ATUAL%"=="2" echo     ^> INTERMEDIÁRIO
    if "%MODO_ATUAL%"=="3" echo     ^> COMPLETO ^(silencioso - sem perguntas^)
    echo ============================================================
    echo.

    for /l %%i in (1,1,%TAREFA_TOTAL%) do (
        call :TarefaRodaNoModo %%i %MODO_ATUAL%
        if "!MATCH!"=="1" call :ExecutarTarefa %%i
        set "MATCH="
    )

    echo.
    echo [OK] Modo concluído.
    echo.
    pause
    set "MODO_SILENCIOSO=0"
goto :eof


:TarefaRodaNoModo
    set "MATCH="
    set "N=%~1"
    set "MODO_ALVO=%~2"
    set "MODOS=!TAREFA_%N%_MODOS!"
    for %%M in (!MODOS!) do (
        if "%%M"=="!MODO_ALVO!" set "MATCH=1"
    )
goto :eof


REM ============================================================================
REM  MODO CUSTOMIZADO
REM ============================================================================
:ModoCustomizado
    set "MODO_SILENCIOSO=0"

    cls
    echo ============================================================
    echo   MODO CUSTOMIZADO
    echo ============================================================
    echo.
    echo   Responda [S] para executar ou [N] para pular cada tarefa.
    echo.
    pause

    for /l %%i in (1,1,%TAREFA_TOTAL%) do (
        call :PerguntarTarefa %%i
    )

    echo.
    echo [OK] Execução customizada concluída.
    echo.
    pause
goto :eof


:PerguntarTarefa
    set "N=%~1"
    call set "T_DESC=%%TAREFA_%N%_DESC%%"

    cls
    echo ------------------------------------------------------------
    echo   Tarefa %N%:  !T_DESC!
    echo ------------------------------------------------------------
    echo.
    set "RESP="
    set /p "RESP=Executar esta tarefa? [S/N]: "
    if /i "!RESP!"=="S" call :ExecutarTarefa %N%
goto :eof


REM ============================================================================
REM  EXECUTOR PADRÃO DE UMA TAREFA
REM ============================================================================
:ExecutarTarefa
    set "N=%~1"
    call set "T_LABEL=%%TAREFA_%N%_LABEL%%"
    call set "T_DESC=%%TAREFA_%N%_DESC%%"

    echo.
    echo ------------------------------------------------------------
    echo   [TAREFA %N%] !T_DESC!
    echo ------------------------------------------------------------
    call :!T_LABEL!
    echo.
    echo [OK] Tarefa %N% concluída.
goto :eof


REM ============================================================================
REM  HELPERS
REM ============================================================================

REM Uso: call :DefinirPolitica "CHAVE" "VALOR" "DADOS" [TIPO]
:DefinirPolitica
    set "TIPO=%~4"
    if "!TIPO!"=="" set "TIPO=REG_DWORD"
    reg add "%~1" /v "%~2" /t !TIPO! /d "%~3" /f >nul 2>&1
    if !errorlevel! neq 0 (
        echo   [ERRO] Falha ao definir %~2 em %~1
    ) else (
        echo   [OK] %~2 = %~3
    )
goto :eof

REM Uso: call :PerguntarSN "Mensagem"
REM      Define RESPOSTA_SN como S ou N.
REM      Se MODO_SILENCIOSO=1, assume S sem perguntar.
:PerguntarSN
    if "!MODO_SILENCIOSO!"=="1" (
        echo.
        echo   [MODO COMPLETO] %~1
        echo   [MODO COMPLETO] Resposta assumida automaticamente: S
        set "RESPOSTA_SN=S"
        goto :eof
    )
    echo.
    set "RESP="
    set /p "RESP=%~1 [S/N]: "
    if /i "!RESP!"=="S" (set "RESPOSTA_SN=S") else (set "RESPOSTA_SN=N")
goto :eof

REM Uso: call :DesativarServico "NomeTecnico" "NomeAmigavel"
REM      Para e desabilita o serviço. Ignora se não existir.
:DesativarServico
    sc query "%~1" >nul 2>&1
    if !errorlevel! neq 0 (
        echo   [AVISO] Serviço "%~2" não existe neste sistema. Pulando.
        goto :eof
    )
    sc stop "%~1" >nul 2>&1
    sc config "%~1" start= disabled >nul 2>&1
    if !errorlevel! neq 0 (
        echo   [ERRO] Falha ao desativar "%~2" ^(%~1^)
    ) else (
        echo   [OK] "%~2" desativado.
    )
goto :eof


REM ============================================================================
REM  TAREFAS - POLÍTICAS / REGEDIT
REM ============================================================================

:TAREFA_CompressorMemoria
    echo [INFO] Executando Disable-MMAgent -mc via PowerShell...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-MMAgent -mc"
    if !errorlevel! neq 0 (
        echo [ERRO] Falha ao executar Disable-MMAgent -mc
    ) else (
        echo [OK] Compressor de memória desativado.
    )
goto :eof


:TAREFA_DadosDiagnostico
    echo [INFO] Desativando coleta de dados de diagnóstico...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" "0"
goto :eof


:TAREFA_CompatibilidadeApps
    echo [INFO] Desativando telemetria e mecanismos de compatibilidade...
    set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
    call :DefinirPolitica "!K!" "AITEnable" "0"
    call :DefinirPolitica "!K!" "DisableEngine" "1"
    call :DefinirPolitica "!K!" "DisablePCA" "1"
    call :DefinirPolitica "!K!" "DisableInventory" "1"
    call :DefinirPolitica "!K!" "DisableSwitchback" "1"
    call :DefinirPolitica "!K!" "DisableUAR" "1"
goto :eof


:TAREFA_ConteudoNuvem
    echo [INFO] Desativando conteúdos e experiências em nuvem...
    set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    call :DefinirPolitica "!K!" "DisableCloudOptimizedContent" "1"
    call :DefinirPolitica "!K!" "DisableConsumerAccountStateContent" "1"
    call :DefinirPolitica "!K!" "DisableWindowsCopilotPinning" "1"
    call :DefinirPolitica "!K!" "DisableWindowsSpotlightWindowsWelcomeExperience" "1"
    call :DefinirPolitica "!K!" "DisableWindowsSpotlightFeatures" "1"
    call :DefinirPolitica "!K!" "DisableWindowsConsumerFeatures" "1"
goto :eof


:TAREFA_ControleVoz
    echo [INFO] Desativando atualização automática de dados de fala...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Speech" "AllowSpeechModelUpdate" "0"
goto :eof


:TAREFA_ExploradorArquivos
    echo [INFO] Desativando insights baseados em conta no Explorador...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "DisableGraphRecentItems" "1"
goto :eof


:TAREFA_PushToInstall
    echo [INFO] Desativando serviço de Instalação por Push...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\PushToInstall" "DisablePushToInstall" "1"
goto :eof


:TAREFA_LocalSensores
    echo [INFO] Desativando Local...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocation" "1"
goto :eof


:TAREFA_LocalizadorWindows
    echo [INFO] Desativando Fornecedor de Local do Windows...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableWindowsLocationProvider" "1"
goto :eof


:TAREFA_MicrosoftStore
    echo [AVISO] Desabilitar este serviço pode afetar a experiência de quem faz
    echo         uso dos serviços do XBOX GamePass, atualizações de programas
    echo         pré-instalados e instalados pela Microsoft Store.
    call :PerguntarSN "Deseja desativar completamente os serviços da Microsoft Store?"
    if "!RESPOSTA_SN!"=="S" (
        echo [INFO] Desativando completamente a Microsoft Store...
        call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "RemoveWindowsStore" "1"
    ) else (
        echo [INFO] Mantendo Store ativa, mas desativando downloads automáticos...
        call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" "2"
    )
goto :eof


:TAREFA_MicrosoftEdge
    echo [INFO] Desativando prelaunch, startup boost e pré-carregamento do Edge...
    set "K=HKLM\SOFTWARE\Policies\Microsoft\Edge"
    call :DefinirPolitica "!K!" "AllowPrelaunch" "0"
    call :DefinirPolitica "!K!" "StartupBoostEnabled" "0"
    call :DefinirPolitica "!K!" "TabPreloading" "2"
goto :eof


:TAREFA_Pesquisa
    echo [INFO] Desativando Cortana, pesquisa em nuvem e web...
    set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    call :DefinirPolitica "!K!" "AllowCortana" "0"
    call :DefinirPolitica "!K!" "AllowCloudSearch" "0"
    call :DefinirPolitica "!K!" "AllowSearchHighlights" "0"
    call :DefinirPolitica "!K!" "AllowSearchToUseLocation" "0"
    call :DefinirPolitica "!K!" "AlwaysUseAutoLangDetection" "0"
    call :DefinirPolitica "!K!" "PreventIndexingOnBattery" "1"
    call :DefinirPolitica "!K!" "DisableWebSearch" "1"
    call :DefinirPolitica "!K!" "ConnectedSearchUseWeb" "0"
    call :DefinirPolitica "!K!" "ConnectedSearchUseWebOverMeteredConnections" "0"
goto :eof


:TAREFA_PrivacidadeApps
    echo [INFO] Restringindo privacidade de aplicativos (Forçar Negação)...
    set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
    call :DefinirPolitica "!K!" "LetAppsAccessAccountInfo" "2"
    call :DefinirPolitica "!K!" "LetAppsAccessMotion" "2"
    call :DefinirPolitica "!K!" "LetAppsAccessEyeTracker" "2"
    call :DefinirPolitica "!K!" "LetAppsAccessGraphicsCaptureProgrammatic" "2"
    call :DefinirPolitica "!K!" "LetAppsAccessGraphicsCaptureWithoutBorder" "2"
    call :DefinirPolitica "!K!" "LetAppsAccessPresence" "2"
    call :DefinirPolitica "!K!" "LetAppsRunInBackground" "2"
    call :DefinirPolitica "!K!" "LetAppsAccessForegroundAppText" "2"
goto :eof


:TAREFA_RelatoriosErros
    echo [AVISO] Desativar esta opção pode afetar a experiência de quem gosta de
    echo         analisar o relatório de erros e logs fornecidos pelo Windows
    echo         após algum eventual problema de serviço, desempenho, etc.
    call :PerguntarSN "Deseja desativar os Relatórios de Erros do Windows?"
    if "!RESPOSTA_SN!"=="S" (
        set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting"
        call :DefinirPolitica "!K!" "Disabled" "1"
        call :DefinirPolitica "!K!" "LoggingDisabled" "1"
    ) else (
        echo [INFO] Mantendo configurações atuais.
    )
goto :eof


:TAREFA_SincronizarConfig
    echo [AVISO] Desabilitar este serviço pode afetar a experiência do usuário em
    echo         querer sincronizar configurações do sistema, aplicativos,
    echo         personalização, senhas, idioma e etc, em um futuro login com a
    echo         conta Microsoft em um novo equipamento ou recém-formatado.
    call :PerguntarSN "Deseja desativar a sincronização de configurações?"
    if "!RESPOSTA_SN!"=="S" (
        set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync"
        call :DefinirPolitica "!K!" "DisableSettingSync" "2"
        call :DefinirPolitica "!K!" "DisableSettingSyncUserOverride" "1"
    ) else (
        echo [INFO] Mantendo configurações atuais.
    )
goto :eof


:TAREFA_WindowsUpdate
    echo [INFO] Configurando Windows Update para avisar antes de baixar...
    set "KAU=HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    call :DefinirPolitica "!KAU!" "NoAutoUpdate" "0"
    call :DefinirPolitica "!KAU!" "AUOptions" "2"
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "UpdateNotificationLevel" "2"
goto :eof


:TAREFA_MenuIniciar
    echo [INFO] Desativando histórico de documentos recentes...
    call :DefinirPolitica "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoRecentDocsHistory" "1"
goto :eof


:TAREFA_IdAnuncio
    echo [INFO] Desligando a ID de anúncio...
    call :DefinirPolitica "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" "DisabledByGroupPolicy" "1"
goto :eof


:TAREFA_PoliticasSO
    echo [INFO] Desativando sincronização de clipboard e Feed de Atividades...
    set "K=HKLM\SOFTWARE\Policies\Microsoft\Windows\System"
    call :DefinirPolitica "!K!" "AllowCrossDeviceClipboard" "0"
    call :DefinirPolitica "!K!" "EnableActivityFeed" "0"
    call :DefinirPolitica "!K!" "PublishUserActivities" "0"
    call :DefinirPolitica "!K!" "UploadUserActivities" "0"
goto :eof


REM ============================================================================
REM  TAREFAS - SERVIÇOS
REM ============================================================================

REM ----------------------------------------------------------------------------
REM  GRUPO A - Telemetria e Privacidade
REM ----------------------------------------------------------------------------
:TAREFA_SvcTelemetria
    echo [INFO] Desativando serviços de telemetria e privacidade...
    call :DesativarServico "DiagTrack" "Connected User Experiences and Telemetry"
    call :DesativarServico "DPS" "Diagnostic Policy Service"
    call :DesativarServico "WdiServiceHost" "Diagnostic Tracking Service"
    call :DesativarServico "WerSvc" "Windows Error Reporting Service"
    call :DesativarServico "PcaSvc" "Program Compatibility Assistant Service"
goto :eof


REM ----------------------------------------------------------------------------
REM  GRUPO B - Serviços Legados
REM ----------------------------------------------------------------------------
:TAREFA_SvcLegados
    echo [INFO] Desativando serviços legados...
    call :DesativarServico "Fax" "Fax"
    call :DesativarServico "RemoteRegistry" "Remote Registry"
    call :DesativarServico "seclogon" "Secondary Logon"
goto :eof


REM ----------------------------------------------------------------------------
REM  GRUPO C - Serviços do Xbox
REM ----------------------------------------------------------------------------
:TAREFA_SvcXbox
    echo [INFO] Desativando serviços do Xbox...
    call :DesativarServico "XblAuthManager" "Xbox Live Auth Manager"
    call :DesativarServico "XblGameSave" "Xbox Live Game Save"
    call :DesativarServico "XboxNetApiSvc" "Xbox Live Networking Service"
    call :DesativarServico "XboxGipSvc" "Xbox Accessory Management Service"
goto :eof


REM ----------------------------------------------------------------------------
REM  GRUPO D - Serviços de Telefonia
REM ----------------------------------------------------------------------------
:TAREFA_SvcTelefonia
    echo [INFO] Desativando serviços de telefonia...
    call :DesativarServico "TapiSrv" "Telephony"
    call :DesativarServico "PhoneSvc" "Phone Service"
    call :DesativarServico "CellTime" "Cellular Time"
    call :DesativarServico "CellularSvc" "Cellular Service"
    call :DesativarServico "PhoneLineVoicemail" "Phone Line Voicemail"
goto :eof


REM ----------------------------------------------------------------------------
REM  GRUPO E - Performance
REM ----------------------------------------------------------------------------
:TAREFA_SvcPerformance
    echo [INFO] Desativando serviços de otimização/performance...
    call :DesativarServico "SysMain" "SysMain (Superfetch)"
    call :DesativarServico "WSearch" "Windows Search"
    call :DesativarServico "DoSvc" "Delivery Optimization"
goto :eof


REM ----------------------------------------------------------------------------
REM  GRUPO F - IA
REM ----------------------------------------------------------------------------
:TAREFA_SvcIA
    echo [INFO] Desativando serviços de IA...
    call :DesativarServico "Copilot" "Copilot"
    call :DesativarServico "WindowsAISvc" "Windows AI Service"
goto :eof


REM ============================================================================
REM  SAÍDA
REM ============================================================================
:Sair
    echo.
    echo Encerrando...
    timeout /t 2 >nul
    endlocal
    exit /b 0