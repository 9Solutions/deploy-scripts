# Use uma imagem base do OpenJDK para rodar a aplicação Java
FROM openjdk:17-alpine

# Instala o Git
RUN apk add --no-cache git

# Define o diretório de trabalho no container
WORKDIR /app

# Define as variáveis de ambiente para o repositório Git e o branch
ENV GIT_REPO=https://github.com/9Solutions/backend.git
ENV GIT_BRANCH=deploy

# Faz o clone do repositório
RUN git clone -b $GIT_BRANCH $GIT_REPO /app

# Expor a porta em que o Spring Boot rodará
EXPOSE 8080

# Comando para rodar a aplicação Spring Boot
CMD ["sh", "-c", "git pull && cd api-rest-v3 && chmod +x mvnw && ./mvnw clean package && java -jar target/*.jar"]