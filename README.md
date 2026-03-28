# iBuild — Flutter App

Plataforma de gestão de produção para engenharia e construção.

## Stack Tecnológica

| Camada | Tecnologia |
|--------|-----------|
| Framework | Flutter 3.x + Dart 3.x |
| Backend / Auth | Supabase |
| Estado global | Riverpod 2 + riverpod_annotation |
| Banco local (offline) | Drift (SQLite) |
| Navegação | GoRouter |
| UI | Material 3 + Google Fonts |
| QR Code | mobile_scanner |
| PDF | pdf + printing |

## Arquitetura — Clean Architecture

```
lib/
├── core/                     # Infraestrutura e configurações
│   ├── constants/            # Constantes do app
│   ├── theme/                # Design system iBuild
│   ├── network/              # Router (GoRouter)
│   ├── providers/            # Auth e providers globais
│   └── utils/                # Helpers e extensões
│
├── data/                     # Camada de dados
│   ├── local/
│   │   ├── database/         # Drift — schema do banco local
│   │   └── daos/             # Data Access Objects
│   ├── remote/
│   │   └── supabase/         # Queries e RPCs do Supabase
│   ├── models/               # DTOs e modelos de dados
│   ├── repositories/         # Implementações dos repositórios
│   └── sync/                 # Motor de sincronização offline
│
├── domain/                   # Regras de negócio (puras)
│   ├── entities/             # Entidades do domínio
│   ├── repositories/         # Interfaces (abstrações)
│   └── usecases/             # Casos de uso
│
└── presentation/             # UI — organizada por feature
    ├── common/               # Widgets e providers compartilhados
    ├── auth/                 # Login e seleção de projeto
    ├── home/                 # Dashboard
    ├── apontamento/          # 🔑 MVP — Apontamento de produção
    ├── folha_tarefa/         # Programação e FT
    ├── eap/                  # EAP e avanço
    ├── itens/                # Detalhamento de componentes
    └── configuracao/         # Configurações do app
```

## Configuração inicial

### 1. Pré-requisitos
- Flutter SDK >= 3.3.0
- Dart SDK >= 3.3.0
- Android Studio ou VS Code com extensões Flutter
- Conta no Supabase (supabase.com)

### 2. Clonar e instalar dependências
```bash
git clone https://github.com/seu-usuario/ibuild-app.git
cd ibuild-app
flutter pub get
```

### 3. Configurar Supabase
1. Crie um projeto em [supabase.com](https://supabase.com)
2. Execute o schema em `docs/ibuild_schema.sql` no SQL Editor
3. Copie a URL e Anon Key do projeto
4. Edite `lib/core/constants/app_constants.dart`:
```dart
static const supabaseUrl     = 'https://SEU_PROJETO.supabase.co';
static const supabaseAnonKey = 'SUA_ANON_KEY';
```

### 4. Gerar código (build_runner)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Rodar o app
```bash
# Android
flutter run

# Chrome (PWA)
flutter run -d chrome

# Gerar APK
flutter build apk --release

# Gerar APK por ABIs (menor tamanho)
flutter build apk --split-per-abi
```

## Módulos — Ordem de desenvolvimento (MVP)

| Sprint | Módulo | Status |
|--------|--------|--------|
| 1 | Auth (Login + Seleção de Projeto) | 🔨 Em desenvolvimento |
| 1 | Apontamento de Produção (campo) | 🔨 Em desenvolvimento |
| 2 | Scanner QR Code de tickets | 🔨 Em desenvolvimento |
| 2 | Offline sync (Drift + fila) | 📋 Planejado |
| 3 | Folha Tarefa | 📋 Planejado |
| 4 | EAP e Avanço | 📋 Planejado |
| 5 | Detalhamento de Itens | 📋 Planejado |
| 6 | Suprimentos (RMA) | 📋 Planejado |
| 7 | Relatórios e PDF | 📋 Planejado |

## Estratégia Offline-First

O iBuild foi projetado para funcionar **100% sem internet** em campo:

1. **Drift** mantém cópia local de todos os dados necessários
2. Apontamentos criados offline recebem um `id_offline` (UUID)
3. Uma **fila de sync** (`FilaSync`) registra todas as operações pendentes
4. Quando a rede voltar, o `SyncNotifier` processa a fila em ordem
5. O Supabase usa `id_offline` para deduplicação (evita duplicatas)

## Design System iBuild

- **Cor primária:** `#A51C30` (vermelho iBuild)
- **Tipografia:** Google Fonts Inter
- **Modo campo (dark):** ativado automaticamente à noite ou por preferência
- **Tamanho mínimo de toque:** 44px (ergonomia com luvas/campo)

## Variáveis de ambiente (produção)

Para produção, use `--dart-define` ou um `.env`:
```bash
flutter build apk \
  --dart-define=SUPABASE_URL=https://xxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=xxx
```

## Contato e suporte

iBuild — contato@ibuild.com.br
