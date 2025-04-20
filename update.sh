#!/bin/bash

# Função para verificar e rodar o comando com sudo
sudo_cmd="sudo"

# Função para verificar se o script está sendo executado como root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Este script deve ser executado com permissões de superusuário (sudo)."
        exit 1
    fi
}

# Atualizar a lista de pacotes
update_system() {
    echo "Atualizando a lista de pacotes disponíveis..."
    $sudo_cmd apt update
}

# Atualizar pacotes instalados
upgrade_system() {
    echo "Atualizando pacotes instalados..."
    $sudo_cmd apt upgrade -y
}


# Limpar pacotes desnecessários
clean_system() {
    echo "Limpando pacotes desnecessários..."
    $sudo_cmd apt autoremove -y
    $sudo_cmd apt clean
}


# Função principal para rodar todas as operações
main() {
    check_root
    update_system
    upgrade_system
    clean_system
    echo "Sistema Ubuntu atualizado com sucesso!"
}

# Chama a função principal
main

notify-send "Startup Script" "O script de atualização foi executado com sucesso."

