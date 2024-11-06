#!/bin/bash
# Last Update: 2024 Nov 11 (Wed)

# Informações do repositório
GITHUB_USER="rpassosdomingues"
GITHUB_EMAIL="rafael.domingues@sou.unifal-mg.edu.br"
REPOS=("cache" "main" "tmp" "insights")
COMMIT_MESSAGE="2024 Nov 11 (Wed)"
FILE_NAME="README.md"

# Configura o Git com nome de usuário e e-mail
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

for REPO_NAME in "${REPOS[@]}"; do
    # Verifica se o diretório já existe
    if [ ! -d "$REPO_NAME" ]; then
        # Cria o diretório se não existir
        mkdir "$REPO_NAME"
    fi

    cd "$REPO_NAME"

    # Inicializa o repositório Git
    git init

    # Cria o arquivo README.md com algum conteúdo
    echo "# $REPO_NAME" > "$FILE_NAME"

    # Adiciona o README.md ao repositório
    git add "$FILE_NAME"

    # Faz o primeiro commit, se não houver nada para commit, esse comando pode falhar
    git commit -m "$COMMIT_MESSAGE" || true  # Ignora erro se nada for adicionado

    # Verifica se o repositório remoto já está configurado
    if git remote get-url origin > /dev/null 2>&1; then
        # Se o remoto já existir, altera a URL
        git remote set-url origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
    else
        # Se não existir, adiciona o remoto
        git remote add origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
    fi

    # Garante que o branch 'main' existe, sem tentar criar novamente
    git checkout main || git checkout -b main

    # Realiza o push do código para o GitHub
    git push -u origin main

    # Volta para o diretório pai
    cd ..
done
