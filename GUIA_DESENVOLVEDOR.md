# iBuild Flutter — Guia do Desenvolvedor
## Entregando em 1 semana

---

## 1. Setup inicial (30 minutos)

### Pré-requisitos
```bash
flutter --version   # >= 3.19.0
dart --version      # >= 3.3.0
```

Se não tiver Flutter instalado:
```bash
# macOS/Linux
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"

# Windows: baixar em https://docs.flutter.dev/get-started/install
```

### Clonar e instalar
```bash
cd ibuild_app
flutter pub get
```

---

## 2. Configurar Supabase (15 minutos)

### 2.1 Criar projeto
1. Acesse https://supabase.com → New project
2. Nome: `ibuild-producao`
3. Senha do banco: guarde em local seguro
4. Região: South America (São Paulo)

### 2.2 Aplicar o schema
1. No Supabase → SQL Editor
2. Abra o arquivo `docs/ibuild_schema.sql`
3. Execute (F5 ou Run)
4. Aguardar ~30 segundos

### 2.3 Configurar o app
Edite `lib/core/constants/app_constants.dart`:
```dart
static const supabaseUrl     = 'https://XXXXXXXXXXX.supabase.co';
static const supabaseAnonKey = 'eyJhbGc...';
```

URL e Anon Key estão em: Supabase → Settings → API

### 2.4 Criar primeiro usuário
No Supabase → Authentication → Users → Add user:
- Email: admin@ibuild.com.br
- Password: (defina uma senha forte)

### 2.5 Criar tenant e dados iniciais
Execute no SQL Editor:
```sql
-- Criar tenant
INSERT INTO tenants (nome, slug, plano)
VALUES ('Empresa Teste', 'teste', 'pro')
RETURNING id;

-- Usar o ID retornado abaixo (substitua 'SEU-TENANT-ID')

-- Criar perfil para o usuário admin
-- Primeiro obtenha o UUID do usuário em Authentication → Users
INSERT INTO perfis (id, tenant_id, nome, email, tipo_perfil)
VALUES (
  'UUID-DO-USUARIO-AQUI',
  'SEU-TENANT-ID',
  'Administrador',
  'admin@ibuild.com.br',
  'admin'
);

-- Criar projeto e OS de exemplo
INSERT INTO projetos (tenant_id, codigo, nome, status)
VALUES ('SEU-TENANT-ID', 'PROJ-001', 'Projeto Piloto', 'ativo')
RETURNING id;

INSERT INTO ordens_servico (tenant_id, projeto_id, codigo, nome)
VALUES ('SEU-TENANT-ID', 'ID-DO-PROJETO', '0001', 'OS Principal')
RETURNING id;

INSERT INTO subprojetos (tenant_id, os_id, codigo, nome)
VALUES ('SEU-TENANT-ID', 'ID-DA-OS', 'PIPE', 'Tubulação')
RETURNING id;
```

---

## 3. Gerar código automático (5 minutos)

Este passo é OBRIGATÓRIO — sem ele o app não compila:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Se der erro de conflito:
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

Arquivos gerados (não editar manualmente):
- `*.g.dart` — providers Riverpod e DAOs Drift
- `*.freezed.dart` — modelos imutáveis

---

## 4. Rodar o app

### Android (recomendado para campo)
```bash
flutter run                        # debug
flutter run --release              # release
flutter build apk --release        # gera APK
flutter build apk --split-per-abi  # APKs menores por arquitetura
```

APK gerado em: `build/app/outputs/flutter-apk/`

### PWA (web para gestores)
```bash
flutter run -d chrome
flutter build web --release
```

### iOS (requer Mac com Xcode)
```bash
flutter run -d ios
flutter build ios --release
```

---

## 5. Dependências com código nativo — configurações adicionais

### Android — permissions (já deve estar no AndroidManifest.xml)
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### mobile_scanner (câmera para QR Code)
Adicionar em `android/app/build.gradle`:
```groovy
android {
    compileSdkVersion 34
    defaultConfig {
        minSdkVersion 21  // mínimo para mobile_scanner
    }
}
```

### printing (PDF)
Nenhuma configuração extra necessária para Android/iOS.
Para web: adicionar ao `web/index.html`:
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfjs-dist/3.11.174/pdf.min.js"></script>
```

---

## 6. Estrutura do projeto

```
lib/
├── core/
│   ├── constants/app_constants.dart    ← URL Supabase aqui
│   ├── theme/app_theme.dart            ← Design system iBuild
│   ├── network/router.dart             ← Todas as rotas
│   └── providers/auth_provider.dart   ← Auth + contexto global
│
├── data/
│   ├── local/database/local_database.dart  ← Drift (offline)
│   ├── local/daos/apontamento_dao.dart     ← Queries locais
│   ├── sync/sync_service.dart              ← Motor de sync
│   ├── pdf/folha_tarefa_pdf.dart           ← Geração de PDF
│   └── models/contexto_usuario.dart        ← Dados da sessão
│
└── presentation/
    ├── auth/         ← Login + seleção de projeto
    ├── home/         ← Dashboard + painel de controle
    ├── apontamento/  ← MVP do campo (QR + baixa)
    ├── folha_tarefa/ ← FT + programação
    ├── eap/          ← EAP + avanço + aprovação
    ├── construcao/   ← Detalhamento + seleção + suprimentos
    ├── planejamento/ ← Importação EAP + aprovação EAP
    ├── configuracao/ ← Configurações do app
    └── configuracao_sistema/ ← Disciplinas, fases, eventos, áreas
```

---

## 7. Problemas comuns

### "Could not find package 'X'"
```bash
flutter pub get
```

### "type 'Null' is not a subtype of type 'String'"
Verificar se o schema foi aplicado corretamente no Supabase. Tabelas podem estar vazias.

### "SocketException: Connection refused"
- Verificar URL do Supabase em `app_constants.dart`
- Verificar conexão com internet no dispositivo

### Build runner não gera arquivos
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Câmera não abre no simulador
Testar em dispositivo físico — simuladores não têm câmera real.

### PDF não renderiza no iOS
Adicionar ao `ios/Podfile`:
```ruby
pod 'PDFKit'
```

---

## 8. Módulos implementados e status

| Módulo | Arquivo | Status |
|--------|---------|--------|
| Login | auth/pages/login_page.dart | ✅ Completo |
| Seleção de projeto | auth/pages/selecao_projeto_page.dart | ✅ Completo |
| Dashboard | home/pages/home_page.dart | ✅ Completo |
| Painel de controle | home/pages/painel_controle_page.dart | ✅ Completo |
| Apontamento (campo) | apontamento/pages/ | ✅ Completo |
| Scanner QR Code | apontamento/pages/scanner_ticket_page.dart | ✅ Completo |
| Folha Tarefa | folha_tarefa/pages/folha_tarefa_page.dart | ✅ Completo |
| PDF Folha Tarefa | data/pdf/folha_tarefa_pdf.dart | ✅ Completo |
| EAP + Avanço | eap/pages/eap_page.dart | ✅ Completo |
| Aprovação EAP | planejamento/pages/aprovacao_eap_page.dart | ✅ Completo |
| Importação EAP | planejamento/pages/importacao_eap_page.dart | ✅ Completo |
| Detalhamento | construcao/pages/detalhamento_page.dart | ✅ Completo |
| Seleção de componentes | construcao/pages/selecao_componente_page.dart | ✅ Completo |
| Suprimentos / RMA | construcao/pages/suprimentos_page.dart | ✅ Completo |
| Config sistema | configuracao_sistema/pages/ | ✅ Completo |
| Config avançada | configuracao_sistema/pages/configuracao_avancada_page.dart | ✅ Completo |
| Sync offline | data/sync/sync_service.dart | ✅ Arquitetura |
| Banco local | data/local/database/local_database.dart | ✅ Schema |

---

## 9. Checklist de entrega para o cliente

- [ ] Schema Supabase aplicado
- [ ] Tenant e dados iniciais criados
- [ ] build_runner executado sem erros
- [ ] App rodando em dispositivo Android físico
- [ ] Login funciona com usuário criado
- [ ] Seleção de projeto carrega dados do Supabase
- [ ] Apontamento registra no banco
- [ ] PDF da Folha Tarefa gera corretamente
- [ ] QR Code scanner funciona
- [ ] APK de release gerado e instalado no dispositivo do cliente

---

## 10. Contato e suporte

iBuild — Sistema de Gestão de Produção para Engenharia e Construção
contato@ibuild.com.br
