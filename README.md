# Benchmarking API — Serialização JSON

Este projeto contém um conjunto mínimo para comparar estratégias de
serialização JSON em Rails (ex.: `as_json`, DTO manual, `panko` e `oj`).
É útil como referência e como base para benchmarks reproducíveis.

**Conteúdo**
- Código do app: modelos `User`, `Post`, `Comment` e serializers/DTOs.
- Tarefa de benchmark: `lib/tasks/benchmark.rake` (usa `benchmark-ips` e `benchmark-memory`).
- Seeds para popular o banco: `db/seeds.rb` (cria dados realistas).

**Pré-requisitos**
- Ruby compatível (o projeto foi gerado com Rails 8.x). Use uma versão moderna do Ruby (ex.: 3.2+ ou conforme seu ambiente).
- SQLite (já usado por padrão no projeto) ou configure outro adaptador em `config/database.yml`.
- Bundler: `gem install bundler` se necessário.

Instalação e preparação

1. Instale gems:

```bash
bundle install
```

2. Criar/migrar o banco (ambiente de sua escolha). Exemplos:

```bash
# ambiente de development
bin/rails db:prepare

# ambiente de production (mais realista para benchmark)
RAILS_ENV=production bin/rails db:prepare
```

3. Popular o banco com os dados de exemplo (o `seeds.rb` gera muitos registros):

```bash
bin/rails db:seed
# ou para production
RAILS_ENV=production bin/rails db:seed
```

Observação: `db/seeds.rb` cria 100 users, 5_000 posts e 20_000 comments por padrão — isso pode levar alguns minutos.

Como rodar os benchmarks

1. Benchmark padrão (development):

```bash
bundle exec rake benchmark:serialization
```

2. Benchmark em `production` (recomendado para resultados mais estáveis):

```bash
RAILS_ENV=production bundle exec rake benchmark:serialization
```

3. Comandos úteis para comparar tamanhos de payload (bytes):

```bash
bin/rails runner "posts = Post.includes(user: {}, comments: :user).limit(1000).to_a; puts ActiveSupport::JSON.encode(PostSerializationStrategies.as_json(posts)).bytesize"
```

Substitua `.as_json` por `.dto`, `.panko`, `.oj` para comparar outputs.

Onde ajustar a carga de teste
- O número de posts usados no benchmark está em `lib/tasks/benchmark.rake` (linha com `limit(1_000)`). Aumente/diminua conforme seu hardware.

Interpretação dos resultados
- `benchmark-ips`: mostra iterações por segundo — maior é melhor.
- `benchmark-memory`: mostra alocações e uso de memória — menor é melhor.
- Compare também o tamanho do JSON gerado para avaliar banda/transferência.

Dicas para resultados confiáveis
- Rode os benchmarks em `RAILS_ENV=production`.
- Feche aplicações/serviços desnecessários antes de medir.
- Execute várias vezes e compare médias/medianas.

Contribuindo
- Abra PRs para adicionar novas estratégias, ajustar seeds ou melhorar medidas.

Licença
- Use a licença que preferir; adicione um `LICENSE` se desejar publicar.

Arquivo principal de referência: `lib/tasks/benchmark.rake` (tarefa que executa os comparativos).

---
Arquivo gerado automaticamente: README atualizado para facilitar uso e contribuição.
