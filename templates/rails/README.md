# Rails Aplication Builder

Este projeto visa padronizar e facilitar a nossa criação de aplicações Rails.

## How it works?

### Docker
Para facilitar o processo de criação utilizamos um container com a imagem de Ruby, isso retira a necessidade de ter o Ruby, Bundler, na máquina local e também auxilia no padronização das versões.

Dentro dessa imagem vamos encontrar o Rails instalado e mais algumas ferramentas auxiliares.

Utilizamos o Docker Compose no auxilio do build dessa imagem para build.

### /templates
Dentro desse diretório temos arquivos de configurações que podem ser copiados para dentro do projeto que será criado.

### /builded
Após executar todos os passos de criação de um novo projeto, é nesse diretório que você encontrará a sua nova aplicação.
Dentro desse diretório você terá todas suas aplicações criadas, vale reparar que esse diretório esta listado no `.gitignore` do projeto `style_guides`, porém um `git init` é executado no diretório dos projetos criados, recomendo que o projeto seja enviado para um `remote` e clonado em seu local de preferencia.

### builder.sh
Arquivo que contém a lista de comandos que auxiliam na criação da imagem e execução do container bem como os seus devidos ajustes de permissão, comandos e pré set de argumentos para os mesmos

## How create a new application

1. `cd {STYLE_GUIDES_PATH}/templates/rails`
2. ./builder.s`
3. Digite o nome da sua aplicação, em letras minúsculas e palavras separadas com `_`
4. O script irá buildar a imagem base (apenas aprecie)
5. O script (builder.sh) irá executar o comando `rails new` com alguns parâmetros, certifique-se de que eles estejam de acordo com suas necessidades.
6. Algumas perguntas serão feitas durante o build, isso vai definir quais `gems` serão instaladas, apenas responsa `y` ou `n`.
7. O script vai alterar a permissão do projeto para o seu usuário e isso vai precisar da sua senha de `sudoer`
8. Com tudo pronto verifique se o seu projeto esta no diretório `{STYLE_GUIDES_PATH}/templates/rails/builded/{APP_NAME}`
9. Entre no diretório do seu novo projeto `{STYLE_GUIDES_PATH}/templates/rails/builded/{APP_NAME}` e envie ele para o `Git`
  1. `git commit -m"Rails new"`
  2. `git remote add origin git@github.com:doghero/{APP_NAME}.git`
  3. `git push -u origin master`
