# Configurando o sistema
Para configurar o sistema no seu computador você precisa do intalar `docker` e `docker compose`.

### Usando com docker

1. Execute the command below for build image
```
docker-compose up -d --no-deps --build app
```
2. Execute the command below for start project
```
docker compose up -d
```
3. Execute the command below for access bash
```
docker compose run --rm app bash
```
4. Execute the command below for create database
```
rails db:create
```
5. Execute the command below for migration database
```
rails db:migrate
```
6. Execute the command below for populate database
```
rails db:seed
```
7. Create file `.env.sidekiq` and add values below:
```
REDIS_URL=redis://redis:6379/0
SIDEKIQ_WORKERS=5
DATABASE_URL=postgres://postgres:postgres@db:5432/projeto_development
```

# Command extras
Reset stats sidekiq
```
Sidekiq::Stats.new.reset
```
For the test rspec, execute the command below
```
ENV_FILE=.env.test docker compose run --rm app rspec
```
For execute rubocop
```
docker compose run --rm app rubocop
```
For debug with binding.pry
```
docker attach --detach-keys="ctrl-c" <id_do_container_app>
```

