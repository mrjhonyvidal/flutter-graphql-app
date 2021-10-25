## CNDV API

O webservice do CDNV está constituído de uma API que centraliza a lógica responsável pelos controle de campanhas de vacinação assim como os tipos de vacinas e as entidades responsáveis por sua aplicação.

### Ferramentas
- Node.js versão >= 10 e npm ou yarn versão >= 1.22.
- GraphQL (^15.5.0) e Apolo Server (^2.21.0)
- MySQL
- New Relic (Monitoring)

Configure suas variáveis em env/dev.env

### DB MySQL
```
sudo docker-compose up
```

### Google Firebase SDK
Para usar Firebase Cloud Messaging é preciso baixar o arquivo service-account.json no próprio painel do Firebase, e para o uso no Heroku as variáveis foram mapeadas no qa.env(env/qa.env ou /env/dev.env) abaixo segue as variáveis sem dados:
```
Dentro de env/qa.env

MYSQL_HOST=
MYSQL_PORT=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_ROOT_PASSWORD=
SECRET_JWT=
FIREBASE_TYPE=
FIREBASE_PROJECT_ID=
FIREBASE_PRIVATE_KEY_ID=
FIREBASE_PRIVATE_KEY=
FIREBASE_CLIENT_EMAIL=
FIREBASE_CLIENT_ID=
FIREBASE_AUTH_URI=
FIREBASE_TOKEN_URI=
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=
FIREBASE_CLIENT_X509_CERT_URL=



```

### Levantar servidor local
```
yarn run dev
open http://localhost:4000/
```

### Deploy backend to Heroku Server
One extra information about our server is that DB is not in Heroku stack, it only holds the Node.js/Express Server.
```
heroku
heroku login
heroku create --remote production
git push production main
```

![graphql-apollo-server](graphql-server-screenshot.png)
![graphql-apollo-server-query-input](graphql-server-query-input.png)

## API - GraphQL

#### Autenticar Usuario
```
# Write your query or mutation here
mutation autenticarUsuario($input: AutenticarInput){
  autenticarUsuario(input: $input) {
    token
  }
}

{
  "input":{
    "cpf": "37192386871",    
    "senha": "letsgo"    
  }
}
```

#### Novo Usuario Acesso
```
# Write your query or mutation here
mutation novoUsuarioAcesso($input: UsuarioInput) {
  novoUsuarioAcesso(input: $input) {
    cpf
    nome
    email
  }
}

{
  "input":{
    "cpf": "1111111111",
    "nome": "Name",
    "senha": "letsgo",
    "email": ""
  }
}
```

#### Autenticar Usuario
```
# Write your query or mutation here
mutation autenticarUsuario($input: AutenticarInput){
  autenticarUsuario(input: $input) {
    token
  }
}

{
  "input":{
    "cpf": "111111111",    
    "senha": "letsgo"    
  }
}
```

#### Obtener Token Usuario e CPF como payload
```
query obtenerUsuario($token: String!){
  obtenerUsuario(token: $token) {
    cpf
  }
}

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIzNzE5MjM4Njg3MSIsImlhdCI6MTYxNDExNDM3OCwiZXhwIjoxNjE0MjAwNzc4fQ.tJVGQMa4g5MrnKPeqZ0cLeBGdcKD3_9OVkkBjIoQCoU"
}

```



#### Queries
```
query getCarteiraTipoVacinas {
  getCarteiraTipoVacinas{
    descricao
    pais
	}
}
```

```
query getCarteiraTipoVacinas {
  getCarteiraTipoVacinas{
    descricao
    pais
	}
}

query obtenerHistoricoVacinacao($cpf: String!){
  obtenerHistoricoVacinacao(cpf: $cpf){
       id
       cpf
       tipo_vacina_descricao
       dt_aplicacao        
       tipo_dose_descricao
       lote
       codigo
       nome_aplicador
       reg_profissional
       unidade_saude
  }
}

{
  "cpf":""
}

mutation atualizarHistoricoVacinacao($id: ID!, $cpf: String!, $input: HistoricoVacinacaoInput){
  atualizarHistoricoVacinacao(id: $id, cpf: $cpf, input: $input) {
  	id
    cpf
    tipo_vacina_descricao
    dt_aplicacao
    tipo_dose_descricao
    lote
    codigo
    nome_aplicador
    reg_profissional
    unidade_saude
    cidade
    uf
  }
}

{
  "id": "3",
  "cpf": "",
  "input": {
    "dt_aplicacao": "2020-07-19",
    "codigo": "84489399"  
  }
}

mutation eliminarHistoricoVacinacao($id: ID!, $cpf: String!) {
  eliminarHistoricoVacinacao(id: $id, cpf: $cpf)
}

{
  "id": "3",
  "cpf": ""
}

query obtainUsuario($token: String!){
  obtainUsuario(token: $token) {
    cpf
  }
}

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIzNzE5MjM4Njg3MSIsImlhdCI6MTYxNDExNDM3OCwiZXhwIjoxNjE0MjAwNzc4fQ.tJVGQMa4g5MrnKPeqZ0cLeBGdcKD3_9OVkkBjIoQCoU"
}

mutation novaCampanha($input: CampanhaInput) {
  novaCampanha(input: $input) {
    id
    nome
    idade_inicio
    idade_final
    cidade
    uf
  }
}

{
  "input":{
    "nome": "Campanha COVID-19 DOSE 1",
    "idade_inicio": 80,
    "idade_final": 90,
    "id_tipo_vacina": 2
    "cidade": "BARUERI",
    "uf": "SP"
  }
}

mutation eliminarCampanha($id: ID!) {
  eliminarHistoricoVacinacao(id: $id)
}

{
  "id": "1"
}


query obtenerCampanha($id: ID!) {
      obtenerCampanha(id: $id){
        id
        nome
        idade_inicio
        idade_final
        cidade
        uf
      }
    }
    
{
  "id": 10
}

mutation novaCampanha($input: CampanhaInput) {
  novaCampanha(input: $input) {
    id
    nome
    idade_inicio
    idade_final
    cidade
    uf
  }
}

{
  "input":{
    "nome": "Campanha COVID-19 DOSE 1",
    "idade_inicio": 80,
    "idade_final": 90,
    "cidade": "BARUERI",
    "uf": "SP"
  }
}



mutation atualizarCampanha($id: ID!, $input: CampanhaInput){
  atualizarCampanha(id: $id, input: $input){
    id
    nome
    idade_inicio
    idade_final
    cidade
    uf
  }
}


mutation atualizarDadosPessoais($cpf: String!, $input: DadosPessoaisInput) {
    atualizarDadosPessoais(cpf: $cpf, input: $input) {
      cpf
      rg
      nome
      dt_nascimento
      email
      contato,
      id_tipo_sanguineo
      doador
      numero
      complemento
      bairro
      cidade
      uf
      pais
      cep
    }
  }

{
  "cpf": "067.879.288-74",  
  "input": {
    "rg": "44",
    "nome": "AU",
    "dt_nascimento": "2012-01-01",
    "email": "jj",
    "contato": "4214",
    "id_tipo_sanguineo": "4",
    "doador": "A+",
    "numero": "41",
    "complemento": "",
    "bairro": "OK",
    "cidade": "1",
    "uf": "FF",
    "pais": "PP",
    "cep": "0022"
  }
}


query obtenerCidades{
        obtenerCidades{
          cidade
          uf
        }
}

Result:
{
  "data": {
    "obtenerCidades": [
      {
        "cidade": "ACRELÂNDIA",
        "uf": "AC"
      },
      {
        "cidade": "ASSIS BRASIL",
        "uf": "AC"
      },
      {
        "cidade": "BRASILÉIA",
        "uf": "AC"
      },
      {
        "cidade": "BUJARI",
        "uf": "AC"
       ....
       
query obtenerCidadesFilteredByUF($uf: String!){
        obtenerCidadesFilteredByUF(uf: $uf){
          cidade
          uf
        }
}

{
  "uf": "RJ"
}        


query obtenerDispositosCidadaoParaCampanha($input: DispositivoCidadaoSearchInput) {
      obtenerDispositosCidadaoParaCampanha(input: $input){    
        idade_inicio
        idade_final
        uf
        municipio
      }
    }
    
{
  "input": {
  	"idade_inicio": "",
  	"idade_final": "",
  	"uf": "",
  	"municipio": ""
	}
}


mutation novoCidadaoDispositivo($input: CidadaoDispositivoInput) {
    novoCidadaoDispositivo(input: $input)
  }

{  
  "input": {
    "cpf": "111.111.111-11",
    "token": "TOKEN_HERE",
    "tipo": "CELULAR_ANDROID"
  }
}

query obtenerDispositosCidadaoParaCampanha($input: DispositivoCidadaoSearchInput) {
      obtenerDispositosCidadaoParaCampanha(input: $input){    
       	dispositivo_token        
      }
    }

    
{
  "input": {
  	"idade_inicio": 30,
  	"idade_final": 40,
  	"uf": "SP",
  	"municipio": "BARUERI"
	}
}

query searchCampanhas($input: CampanhasSearchInput) {
      searchCampanhas(input: $input){    
       	id
        nome
        idade_inicio
        idade_final
        cidade
        uf
      }
    }

    
{
  "input": {
    "tipo": "BCG ID",
  	"idade_inicio": 30,
  	"idade_final": 40,
  	"uf": "SP",
  	"cidade": "BARUERI"
	}
}     
```

### Resources
- [Npm package MySQL2 Github](https://github.com/sidorares/node-mysql2)
- [About Apollo Cache FreeCodeCamp](https://www.freecodecamp.org/news/how-to-update-the-apollo-clients-cache-after-a-mutation-79a0df79b840/)
- [Firebase Node.js Code source](https://github.com/firebase/quickstart-nodejs)
- [Google API Client Libraries](https://developers.google.com/api-client-library/)
- [Firebase Cloud Messaging - Build App Server sed requests](https://firebase.google.com/docs/cloud-messaging/send-message)