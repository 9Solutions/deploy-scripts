# Use uma imagem base do OpenJDK para rodar a aplicação Java
FROM openjdk:17-alpine

# Instala o Git
RUN apk add --no-cache git

# Define o diretório de trabalho no container
WORKDIR /app

# Copia o script de inicialização para o container
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Define as variáveis de ambiente para o repositório Git e o branch
ENV GIT_REPO=https://github.com/9Solutions/backend.git
ENV GIT_BRANCH=deploy

# Expor a porta em que o Spring Boot rodará
EXPOSE 8080

# Comando para rodar a aplicação Spring Boot
CMD ["/app/entrypoint.sh"]
