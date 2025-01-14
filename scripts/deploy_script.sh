npm install -g vercel

# Verifica se as variáveis de ambiente estão definidas
if [ -z "$ORG_ID" ] || [ -z "$PROJECT_ID" ]; then
  echo "Erro: As variáveis de ambiente ORG_ID e PROJECT_ID devem estar definidas."
  exit 1
fi

# Cria o diretório .vercel dentro de build/web (se não existir)
mkdir -p build/web/.vercel

# Gera o arquivo .vercel/project.json com as variáveis de ambiente
cat <<EOL > build/web/.vercel/project.json
{
  "orgId": "$ORG_ID",
  "projectId": "$PROJECT_ID"
}
EOL

echo "Arquivo .vercel/project.json criado com sucesso!"

# Definir o ambiente com base na variável de ambiente ENV
if [ "$ENV" == "production" ]; then
  ENVIRONMENT="--prod"  # Ambiente de produção
else
  ENVIRONMENT=""  # Ambiente de desenvolvimento/preview (padrão)
fi

# Autenticar com o token da Vercel
echo "$VERCEL_TOKEN" | vercel login --token

# Fazer o deploy do diretório build/web para o ambiente configurado
vercel deploy build/web $ENVIRONMENT --token $VERCEL_TOKEN
