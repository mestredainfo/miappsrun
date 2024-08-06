#!/bin/bash

# Copyright (C) 2004-2024 Murilo Gomes Julio
# SPDX-License-Identifier: GPL-2.0-only

# Organização: Mestre da Info
# Site: https://www.mestredainfo.com.br

while true; do
	echo ""
	echo "-------------------------------- CreateExecutable --------------------------------"
    echo "Selecione uma opção:"
    echo "1. Preparar o Ambiente (Linux)"
    echo "2. Preparar o Ambiente (Windows)"
    echo "3. Compilar o MIAppsRun (Linux)"
    echo "4. Compilar o MIAppsRun (Windows)"
    echo "5. Sair"
    echo "-------------------------------- /CreateExecutable --------------------------------"
	echo ""
	
    read -p "Opção: " option

    case $option in
    	1)
            echo "Preparando o ambiente para Linux..."
            rm -rf linux/
            mkdir -p linux/
            cd linux/

    	    echo "Criando diretório mivenv..."
			python3 -m venv mivenv/

			echo "Instalando o pyinstaller..."
			mivenv/bin/pip install pyinstaller
            
            cd ../

			echo "Concluido!"
			;;
        2)
            echo "Preparando o ambiente para Windows..."
            rm -rf win32/
            mkdir -p win32/
            cd win32/

            miDir=$(pwd)

			echo "Criando diretório build/tmp/..."
			mkdir -p build/tmp/
			
    		echo "Baixando o Python-3.11.2..."
			wget -O build/tmp/python-3.11.2.exe https://www.python.org/ftp/python/3.11.2/python-3.11.2.exe

			echo "Configurar para Windows 10..."
			WINEPREFIX="$miDir/build/.wine/" winecfg

			echo "Instalando o Python3... (Remover tudo, deixar só o pip ativado e alterar a localização para C:\Python3\)"
			WINEPREFIX="$miDir/build/.wine/" wine build/tmp/python-3.11.2.exe

			echo "Instalando o PyInstaller..."
			WINEPREFIX="$miDir/build/.wine/" wine build/.wine/drive_c/Python3/python.exe build/.wine/drive_c/Python3/Scripts/pip.exe install pyinstaller
			
            cd ../

			echo "Concluido!"
			;;
	    3)
			echo "Compilando 'miappsrun.py' para Linux..."
			
            rm -f linux/miappsrun.py
            rm -f linux/miappsrun.spec
            rm -rf linux/dist/

            cp miappsrun.py linux/miappsrun.py

            cd linux/

			mivenv/bin/pyinstaller -F miappsrun.py

            cd ../
			
			echo "Concluido!"
			;;
        4)
            echo "Compilando 'miappsrun.py' para Windows..."
			
            rm -f win32/miappsrun.py
            rm -f win32/miappsrun.spec
            rm -rf win32/dist/

            cp miappsrun.py win32/miappsrun.py

            cd win32/
            
			miDir=$(pwd)
			WINEPREFIX="$miDir/build/.wine/" wine build/.wine/drive_c/Python3/Scripts/pyinstaller.exe --onefile miappsrun.py
			
            cd ../

			echo "Concluido!"
			;;
        5)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Por favor, escolha uma opção válida."
            ;;
    esac
done
