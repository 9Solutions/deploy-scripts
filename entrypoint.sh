#!/bin/sh

# Diretório onde o código será clonado
REPO_DIR="backend/api-rest-v3"

# Verifica se o repositório já foi clonado
if [ -d "backend/.git" ]; then
    echo "Atualizando repositório existente..."
    cd "$REPO_DIR"
    git pull origin $GIT_BRANCH
else
    echo "Clonando repositório..."
    git clone -b $GIT_BRANCH $GIT_REPO
    cd "$REPO_DIR"
fi

# Torna o script mvnw executável
chmod +x mvnw

# Compila o projeto
./mvnw clean package

# Executa a aplicação Spring Boot
java -jar target/*.jar
