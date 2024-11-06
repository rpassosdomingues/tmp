#!/bin/bash
# Last Update: 2024 Nov 11 (Wed)

# Informações do repositório
GITHUB_USER="rpassosdomingues"
GITHUB_EMAIL="rafael.domingues@sou.unifal-mg.edu.br"
GITHUB_TOKEN="$GITHUB_TOKEN"  # Variável de ambiente do GitHub Token
REPOS=("cache" "tmp" "main" "insights")
FILE_NAME="README.md"
COMMIT_MESSAGE="Commit inicial"

# Configura o Git com nome de usuário e e-mail
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

for REPO_NAME in "${REPOS[@]}"; do
    # Cria um novo diretório para o repositório
    mkdir $REPO_NAME
    cd $REPO_NAME

    # Inicializa o repositório Git
    git init

    # Cria o arquivo README.md com algum conteúdo
    echo "# $REPO_NAME" >> $FILE_NAME

    # Adiciona o README.md ao repositório
    git add $FILE_NAME

    # Faz o primeiro commit
    git commit -m "$COMMIT_MESSAGE"

    # Associa o repositório local ao repositório remoto no GitHub
    git remote add origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"

    # Realiza o push do código para o GitHub
    git push -u origin main

    # Volta para o diretório pai
    cd ..
done
