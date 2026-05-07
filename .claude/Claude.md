# SthoreH — Contexto do Projeto (Claude.md)

## Visão Geral

SthoreH é uma plataforma de e-commerce serverless na AWS. O sistema permite que clientes naveguem um catálogo de produtos, montem carrinhos de compra e realizem pedidos. Não existe gateway de pagamento — o escopo termina na geração do pedido. Funcionários da empresa acessam um ambiente de administração para gerenciar estoques, produtos, pedidos e clientes.

## Domínio de Negócio

Clientes se cadastram, navegam produtos, adicionam itens ao carrinho e criam pedidos.

O pedido representa uma intenção de compra. Ao ser criado, o sistema reserva estoque de forma síncrona — se não houver estoque suficiente, o checkout é rejeitado imediatamente. Não há fluxo de pagamento; o pedido nasce com status "pending" e segue um ciclo de vida gerenciado pela equipe interna: pending, confirmed, processing, shipped, delivered. Cancelamento pelo cliente só é permitido enquanto o pedido estiver em "pending"; a equipe administrativa pode cancelar de qualquer estado.

## Autenticação e Autorização

A autenticação utiliza o AWS Cognito

## Infraestrutura

Toda infraestrutura é provisionada via Terraform em um diretório `terraform-aws` na raiz. Nenhum recurso é criado manualmente. Terraform versão 1.14.9 com AWS Provider 6.40.0, pinados.

O projeto opera em duas contas AWS na região sa-east-1: "sthore-dev" (branch dev) para desenvolvimento e "sthore-prod" (branch main) para produção. State do Terraform armazenado em S3 com backend parcial configurado via pipeline.

Segredos ficam exclusivamente no AWS Secrets Manager. Nunca em variáveis de ambiente, .tfvars ou código.

Autenticação da pipeline com AWS usa OIDC — sem credenciais armazenadas no GitHub.

## CI/CD

Branches "feature/*" disparam PR com lint, testes e terraform plan. Merge em "dev" faz deploy automático para sthore-dev. Merge em "main" faz deploy para sthore-prod.

Commits seguem Conventional Commits: feat, fix, chore, docs, refactor, test, ci.

## Repositórios

O projeto é organizado em múltiplos repositórios no GitHub sob a organização "SthoreH", seguindo convenção de prefixos: "app-" para aplicações (Lambdas), "infra-" para infraestrutura (DynamoDB, S3), "shd-" para fundações e módulos compartilhados, "tpl-" para templates, "lib-" para bibliotecas, , "docs-" para documentações.
