class AppConstants {
  AppConstants._();

  // ── Supabase ─────────────────────────────────
  // ATENÇÃO: mova para variáveis de ambiente em produção (.env)
  static const supabaseUrl     = 'https://SEU_PROJETO.supabase.co';
  static const supabaseAnonKey = 'SUA_ANON_KEY';

  // ── App ──────────────────────────────────────
  static const appName        = 'iBuild';
  static const appVersion     = '1.0.0';

  // ── Storage Keys ─────────────────────────────
  static const keyTenantId       = 'ibuild_tenant_id';
  static const keyProjetoId      = 'ibuild_projeto_id';
  static const keyOsId           = 'ibuild_os_id';
  static const keySubprojetoId   = 'ibuild_subprojeto_id';
  static const keyTemaEscuro     = 'ibuild_tema_escuro';
  static const keyUltimaSync     = 'ibuild_ultima_sync';

  // ── Offline ──────────────────────────────────
  static const dbLocalNome       = 'ibuild_local.db';
  static const syncIntervalMin   = 5;      // sync a cada 5 minutos
  static const maxRetentativasSync = 3;

  // ── UI ───────────────────────────────────────
  static const animDuration      = Duration(milliseconds: 200);
  static const toastDuration     = Duration(seconds: 3);

  // ── Paginação ────────────────────────────────
  static const pageSize          = 50;
}
