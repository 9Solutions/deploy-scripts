# deploy-scripts

Subir o docker compose
```
sudo docker-compose up -d --build
```
OBS: -d faz rodar em 2 plano

Log do docker-compose
```
sudo docker-compose logs -f
```

Acessar o bash do mysql
```
sudo docker exec -it mysql-container bash
```

Encerrar os serviços
```
sudo docker-compose down
```
