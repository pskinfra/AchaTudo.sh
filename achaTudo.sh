#!/bin/bash

echo 'Este script procura por palavras dentro de arquivos!!!'
echo 'Limpando a tela...'
sleep 2
clear
echo '<Entre> com as palavras que você deseja localizar:'
echo -n "PALAVRA: "
read PALAVRA

echo 'Dependendo da quantidade de combinações encontradas, a lista será mostrada'
echo 'paginada. Para navegar utilize a tecla {q} e para abortar {[ctrl_c]q}'
echo '---------------------------------------------------------------------'
echo 'Para agilizar a busca, <entre> com um Diretório [NÃO use asterisco]...'
echo -n "DIRETÓRIO: "
read DIRETORIO
echo

# Verificar se o diretório existe
if [ ! -d $DIRETORIO ];then
    echo 'Este diretório não existe. Por favor, refaça a busca...'
    echo
	exit
fi

# Alterar IFS(Inter Field Separator) para quebra de linha
oldIFS=$IFS
IFS='
'

# Variáveis de controle(palavras localizadas e não localizadas)
found=0
notfound=0

# verificar se existem arquivos no diretŕio e sub-diretório(s)
if [ `find "$DIRETORIO" -type f | wc -l` -gt 0 ];then

# Percorrer cada arquivo listado
	for file in `find "$DIRETORIO" -type f`;do

# Verificar se o arquivo tem a palavra que buscamos
		if [ `grep -i "$PALAVRA" "$file"` 2> "file" ];then

# Palavra foi encontrada
			echo "Carregado $file..."
			grep -i "$PALAVRA" $file | less
			found=`expr $found + 1`
		else

# Palavra não foi encontrada
			echo "Ignorando $file..."
			notfound=`expr $notfound + 1`
		fi
	done
else
	echo "Este diretório e/ou subdiretório(s) não possuem arquivos..."
	echo
	exit
fi

echo
echo "$(tput setaf 2)Foram econtrados $found arquivo(s) com a palavra $PALAVRA$(tput sgr0)"
echo "$(tput setaf 1)Foram econtrados $notfound arquivo(s) sem a palavra $PALAVRA$(tput sgr0)"
echo

echo '------------------------------------------------------------------------'
echo 'Busca encerrada! Caso não tenha encontrado o que deseja, tente de novo;'
echo 'sendo MENOS específico nas Palavras e MAIS específico no Diretório...'
echo '___Edson_de_Lima___'
echo '------------------------------------------------------------------------'

# Retornar IFS ao padrão
IFS=$oldIFS
