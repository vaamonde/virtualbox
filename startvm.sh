#!/bin/bash
# Autor: Robson Vaamonde
# Procedimentos em TI: http://procedimentosemti.com.br
# Bora para Prática: http://boraparapratica.com.br
# Robson Vaamonde: http://vaamonde.com.br
# Facebook Procedimentos em TI: http://facebook.com/procedimentosemti
# Facebook Bora para Prática: http://facebook.com/boraparapratica
# Instagram Procedimentos em TI: https://www.instagram.com/procedimentoem/
# YouTUBE Bora Para Prática: https://www.youtube.com/boraparapratica
# Data de criação: 21/09/2019
# Data de atualização: 23/09/2019
# Versão: 0.03
# Testado e homologado para a versão do Linux Mint 19.x x64
# Kernel >= 4.15.x e 5.0.x

# Links de apoio para o script do SeamlessRDP
# SeamlessRDP.exe = https://github.com/rdesktop/SeamlessRDP
# SeamlessRDP.sh = https://github.com/fsschmidt/seamlessrdp

# Dependências do script, executar a instalação antes de usar o script
# sudo apt update
# sudo apt install nmap git autoconf libtool m4 automake mingw-w64

# Vídeo aulas de apoio para esse script
# Vídeo aula de Instalação do Linux Mint 19.2: https://www.youtube.com/watch?v=LZoDULxZQpA
# Vídeo aula de Instalação do VirtualBOX 6.0: https://www.youtube.com/watch?v=V2-4oRpm8dw&t
# Vídeo aula de Básico de Shell Script: https://www.youtube.com/watch?v=MkKkZA8wxHU&t
# Vídeo aula de Básico de Git e Github: https://www.youtube.com/watch?v=MkKkZA8wxHU&t

# Declarando as variáveis de ambiente do script
VM="Win7-RDesktop"
USERNAME="vaamonde"
DOMAIN="WORKGROUP"
PASSWORD="pti@2019"
HOST="192.168.1.150"
RDP_PORT="3389"
KEY="pt-br"
COLOR="16"
RESOLUTION="1024x768"

# Em desenvolvimento (falhas de compilação, acesso remoto e execução de aplicativos seamless)
# Acompanhe o arquivo CHANGELOG sobre as mudanças do script e correções: https://github.com/vaamonde/virtualbox/blob/master/CHANGELOG
# Reporte falhas, erros, melhorias, sugestões na opção: ISSUE do Github: https://github.com/vaamonde/virtualbox/issues
# SEAMLESS="c:\seamlessrdp\seamlessrdpshell.exe"
# API="excel.exe"

# Documentação dos comandos utilizandos nesse script:
# case = https://ss64.com/bash/case.html
# echo = https://ss64.com/bash/echo.html
# sleep = https://ss64.com/bash/sleep.html
# nohup = https://ss64.com/bash/nohup.html
# VBoxHeadless = http://manpages.org/vboxheadless
# VBoxManage = http://manpages.org/vboxmanage
# rdesktop-vrdp = https://docs.oracle.com/cd/E97728_01/F12469/html/vrde.html
# &2 = https://ss64.com/nt/syntax-redirection.html
# & = https://ss64.com/nt/syntax-redirection.html
# ping = https://ss64.com/nt/ping.html
# nmap = https://nmap.org/man/pt_BR/index.html
# Seamless = https://github.com/rdesktop/SeamlessRDP

#Iniciando o Bloco de Case para a escolha das opções.
case "$1" in

  start)
        echo "Inicializando a Máquina Virtual $VM"
        nohup VBoxHeadless --startvm $VM &2> /dev/null &
        sleep 2
        echo "Máquina inicializada, aguarde para testar o acesso remoto a $VM"
        echo "Selecione test ou remote para testar o acesso remoto a $VM"
        ;;

  pause)
        echo "Pausando a Máquina Virtual $VM"
        nohup VBoxManage controlvm $VM pause &2> /dev/null &
        sleep 2
        echo "Máquina pausada, selecione reset para iniciar a Máquina Virtual $VM"
        echo "Selecione test ou remote para testar o acesso remoto a $VM"
        ;;

  save)
        echo "Salvando a Máquina Virtual $VM"
        nohup VBoxManage controlvm $VM savestate &2> /dev/null &
        sleep 2
        echo "Máquina salva, selecione start para iniciar a Máquina Virtual $VM"
        echo "Selecione test ou remote para testar o acesso remoto a $VM"
        ;;

  reset)
        echo "Reinicializando a Máquina Virtual $VM"
        nohup VBoxManage controlvm $VM resume &2> /dev/null &
        sleep 2
        echo "Máquina reinicializada, aguarde para testar o acesso remoto a $VM"
        echo "Selecione test ou remote para testar o acesso remoto a $VM"
        ;;

  restart)
        echo "Parando e Inicializando a Máquina Virtual Forçada $VM"
        nohup VBoxManage controlvm $VM poweroff soft &2> /dev/null &
        sleep 3
        nohup VBoxHeadless --startvm $VM &2> /dev/null &
        sleep 2
        echo "Máquina reinicializada, aguarde para testar o acesso remoto a $VM"
        echo "Selecione test ou remote para testar o acesso remoto a $VM"
        ;;

  stop)
        echo "Parando Forçado a Máquina Virtual $VM"
        nohup VBoxManage controlvm $VM poweroff soft &2> /dev/null &
        sleep 2
        echo "Máquina parada, selecione start para iniciar a Máquina Virtual $VM"
        echo "Selecione test ou remote para testar o acesso remoto a $VM"
        ;;

  test)
        echo "Verificando o acesso a Máquina Virtual $VM"
        echo
        echo "Pingando a Máquina Virtual $VM com o Endereço IP $HOST, aguarde..."
        ping -c 4 $HOST
        echo "Teste de ping realizado, continuando com teste..."
        sleep 3
        echo
        echo "Verificando a Porta de Conexão do RDP da Máquina Virtual $VM com o Endereço IP $HOST, aguarde..."
        nmap $HOST | grep $RDP_PORT
        echo "Teste de porta realizado, continuando com teste..."
        sleep 2
        echo
        echo "Teste de ping e porta da Máquina Virtual $VM feito, analisar as mensagens na tela"
        echo "Selecione remote para testar o acesso remoto a $VM"
        ;;

  list)
        echo "Listando todas as Máquinas Virtuais criadas no VirtualBOX"
        echo
        VBoxManage list vms
        echo
        echo "Máquinas listadas com sucesso!!!"
        ;;

  run)
        echo "Listando todas as Máquinas Virtuais rodando no VirtualBOX"
        echo
        VBoxManage list runningvms
        echo
        echo "Máquinas listadas com sucesso!!!"
        ;;

  info)
        echo "Listando informações detalhadas da Máquina Virtual $VM"
        echo
        VBoxManage showvminfo $VM | less
        echo
        echo "Informações listadas com sucesso!!!"
        ;;

  remote)
        echo "Acessando Remotamente a Máquina Virtual: $VM em resolução: $RESOLUTION"
        rdesktop-vrdp -u $USERNAME -d $DOMAIN -p $PASSWORD -k $KEY -b -a $COLOR -g $RESOLUTION $HOST &2> /dev/null &
        sleep 2
        echo "Acesso remoto feito com sucesso na Máquina Virtual $VM"
        ;;

  full)
        echo "Acessando Remotamente a Máquina Virtual $VM em resolução Full Screen"
        rdesktop-vrdp -u $USERNAME -d $DOMAIN -p $PASSWORD -k $KEY -b -a $COLOR -f $HOST &2> /dev/null &
        sleep 2
        echo "Acesso remoto feito com sucesso na Máquina Virtual $VM"
        ;;

# Em desenvolvimento (falhas de compilação, acesso remoto e execução de aplicativos seamless)
#  notepad)
#        echo "Acessando Remotamente ao Bloco de Notas Seamless na Máquina Virtual $VM"
#        rdesktop-vrdp -u $USERNAME -d $DOMAIN -p $PASSWORD -A $SEAMLESS -s 'notepad.exe' -k $KEY -b -a $COLOR $HOST &2> /dev/null &
#        sleep 2
#        echo "Acesso remoto feito com sucesso na Máquina Virtual $VM"
#        ;;

#  api)
#        echo "Acessando Remotamente ao Microsoft Office Excel Seamless na Máquina Virtual $VM"
#        rdesktop-vrdp -u $USERNAME -d $DOMAIN -p $PASSWORD -A $SEAMLESS -s $API -k $KEY -b -a $COLOR $HOST &2> /dev/null &
#        sleep 2
#        echo "Acesso remoto feito com sucesso na Máquina Virtual $VM"
#        ;;

  *)
        echo        
        echo "Escolha as opções: sh $0 {start|pause|save|reset|restart|stop|test|list|run|info|remote|full}" >&2
        echo
        echo "sh startvm.sh start   - Inicia a máquina virtual $VM"
        echo "sh startvm.sh pause   - Pausa a máquina virtual $VM"
        echo "sh startvm.sh save    - Salva a máquina virtual $VM"
        echo "sh startvm.sh reset   - Reinicia a máquina virtual $VM"
        echo "sh startvm.sh restart - Para e Inicia a máquina virtual $VM"
        echo "sh startvm.sh stop    - Para a máquina virtual $VM"
        echo "sh startvm.sh test    - Testa o acesso a máquina virtual $VM"
        echo "sh startvm.sh list    - Lista todas as máquinas virtuais criadas no VirtualBOX"
        echo "sh startvm.sh run     - Lista todas as máquinas virtuais iniciadas no VirtualBOX"
        echo "sh startvm.sh info    - Informações detalhadas da máquina virtual $VM"
        echo "sh startvm.sh remote  - Acesso remoto a máquina virtual $RESOLUTION $VM"
        echo "sh startvm.sh full    - Acesso remoto a máquina virtual full screen $VM"       
        #Em desenvolvimento (falhas de compilação, acesso remoto e execução de aplicativos seamless)
        #echo "sh startvm.sh notepad - Acesso remoto ao software Notepad Seamless na máquina virtual $VM"
        #echo "sh startvm.sh excel   - Acesso remoto ao software Excel Seamless na máquina virtual $VM"
        echo        
        exit 1
        ;;
esac
