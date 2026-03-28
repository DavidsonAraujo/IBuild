import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/network/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Forçar orientação portrait no mobile (campo)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar escura (melhor visibilidade em campo)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Inicializar Supabase
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
    realtimeClientOptions: const RealtimeClientOptions(
      eventsPerSecond: 2,
    ),
  );

  runApp(
    const ProviderScope(
      child: IBuildApp(),
    ),
  );
}

class IBuildApp extends ConsumerWidget {
  const IBuildApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'iBuild',
      debugShowCheckedModeBanner: false,

      // Temas
      theme: IBuildTheme.light,
      darkTheme: IBuildTheme.dark,
      themeMode: ThemeMode.system, // segue o sistema (campo usa dark)

      // Roteamento
      routerConfig: router,

      // Localização
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
    );
  }
}
