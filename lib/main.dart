import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triptide/features/settings/provider/settings_provider.dart';
import 'package:triptide/l10n/app_localizations.dart';

import 'config/routes.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeNotifierProvider);
    final localeAsync = ref.watch(languageNotifierProvider);
    final router = ref.watch(routerProvider);

    return localeAsync.when(
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
      data: (locale) {
        return themeAsync.when(
          error: (_, __) => const SizedBox(),
          loading: () => const SizedBox(),
          data: (themeMode) {
            return MaterialApp.router(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: locale,
              routerConfig: router,
              supportedLocales: const [Locale('en'), Locale('hi')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
