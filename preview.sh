#!/bin/bash
# Script para compilar e fazer preview do Quarto com ambiente virtual ativado

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ativar ambiente virtual
if [ -f .venv/bin/activate ]; then
    source .venv/bin/activate
fi

# Exportar path do Python para o Quarto
export QUARTO_PYTHON="$(which python)"

# Se foi passado um arquivo .qmd como argumento
if [ $# -gt 0 ] && [ "${1: -4}" = ".qmd" ]; then
    QMD_FILE="$1"
    
    # Compilar o arquivo
    echo "Compilando $QMD_FILE..."
    quarto render "$QMD_FILE"
    
    # Abrir o preview
    echo "Abrindo preview..."
    quarto preview "$QMD_FILE"
else
    # Se não foi passado arquivo, mostrar uso
    echo "Uso: $0 <arquivo.qmd>"
    echo "Exemplo: $0 notebooks/06-htg-glarma-model.qmd"
    exit 1
fi
