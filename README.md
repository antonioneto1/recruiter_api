## Base de Projetos Com Docker e Rails

DESCRIÇÃO DO PROJETO

Desafio Técnico Landetech
Prova para vaga Backend

1- Crie um projeto com ruby 2.7.2 e rails 6.0.0

Projeto only api e deve retornar apenas json
Utilizar Jbuilder para views em json | https://github.com/rails/jbuilder
GitHub - rails/jbuilder: Jbuilder: generate JSON objects with a Builder-style DSL
Jbuilder: generate JSON objects with a Builder-style DSL - rails/jbuilder
github.com
CRUD de Recruiters, name, email, password
Sistema de login via JWT, com devise ou nao
Namespace Recruiter
CRUD de Jobs tendo os campos: id, title, description, start_date, end_date, status, skills,
recruiter_id
title Obrigatório
Description Obrigatório
recruiter_id Obrigatório
CRUD Submission name, email, mobile_phone, resume, job_id
namespace publica
api para listagem de vagas com o status ativo + busca de vagas, por titulo, descrição, ou
skills #index
api para pegar os detalhes de uma vaga através do id #show
api para criar um submission #create
Uma pessoa não pode se cadastrar 2x na mesma vaga

Recruiter = Recrutador
Jobs = Vaga
Submission = Candidatura de uma pessoa em uma vaga


### Setup de Desenvolvimento Local

```
    bundle install
```

Estruturar o banco
```
     rails db:migrate
```

Para criar banco
```
      rails db:drop db:create db:migrate
```
Para criar rodar os testes
```
     rspec
```
Subir o servidor 
```
     rails s 
```
Agora a API deve estar disponível em `http://localhost:3000/`.

### Setup de Desenvolvimento Docker

Utilizando Docker e Docker Compose:

```sh
cd api_de_palestras
	ARG_USER_UID=$(id -u) ARG_USER_GID=$(id -g) docker compose config
  ARG_USER_UID=$(id -u) ARG_USER_GID=$(id -g) docker compose build
  docker compose up -d
  docker compose exec app bash
    bundle
    rails db:drop db:create db:migrate
		rspec
    rails s
    # Brower: http://localhost:3000
    # Press: CTRL+C
    exit
  docker compose down
```

### Como Rodar o Projeto

1. Inicie o servidor Rails:

```bash
docker-compose up -d
docker compose exec app bash
  rails s
```

Agora a API deve estar disponível em `http://localhost:3000/`.

### Como Rodar os Testes

1. RSpec para testes de unidade e integração:

    ```bash
    rspec
    ```

### Observações.

No projeto você encontrará uma coleção para importar no postman e fazer as requests.