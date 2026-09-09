# Sistema de Inscricao em Eventos

## Como rodar

### Docker (Postgres + backend)
Na raiz do repositório, execute:

```bash
docker compose up --build -d
```

API em `http://localhost:8083` e verificação de saúde em
`http://localhost:8083/actuator/health`.

Para acompanhar os logs:

```bash
docker compose logs -f backend
```

Para parar os serviços sem apagar os dados do banco:

```bash
docker compose down
```

### Backend local (Spring Boot + Gradle + Java 17)
```
cd backend
./gradlew bootRun
```
API local em `http://localhost:8084`. O Docker continua exposto em
`http://localhost:8083`.

### Imagem Docker isolada
```bash
docker build -t eventos-backend .
docker run --rm -p 8083:8083 -e PORT=8083 -e POSTGRES_HOST=host.docker.internal -e POSTGRES_PORT=5435 -e POSTGRES_DB=eventos -e POSTGRES_USER=eventos -e POSTGRES_PASSWORD=eventos123 eventos-backend
```

### Deploy no Render (usando Docker)
- No painel do Render, escolha "New Web Service" e selecione "Docker".
- Aponte para o repositório e configure a porta: Render fornece `PORT` como variável de ambiente; nossa aplicação respeita `PORT` automaticamente.
- Configure variáveis de ambiente para o banco de dados (`POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`) ou adicione um serviço de banco no Render.


### Frontend (React + Vite)
```
cd frontend
npm install
npm run dev
```
Frontend em `http://localhost:5176`.

## Atividade

Cadastrem um evento, inscrevam alguns participantes ate perto do limite de vagas,
cancelem uma inscricao e tentem inscrever de novo. Reparem no numero de "vagas
restantes" mostrado nas telas.
