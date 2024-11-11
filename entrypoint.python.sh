#!/bin/sh

# Diretório onde o código será clonado
REPO_DIR="Servico-Face-Blur/"

# Verifica se o repositório já foi clonado
if [ -d "$REPO_DIR/.git" ]; then
    echo "Atualizando repositório existente..."
    cd "$REPO_DIR"
    git pull origin $GIT_BRANCH
else
    echo "Clonando repositório..."
    git clone -b $GIT_BRANCH $GIT_REPO
    cd "$REPO_DIR"
fi

# Instala as dependências do projeto
pip install -r requirements.txt

# Executa a aplicação Spring Boot
python main.py