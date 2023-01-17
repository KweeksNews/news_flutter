// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/theme.dart';
import 'firebase_options.dart';
import 'injection.dart';
import 'presentation/l10n/generated/l10n.dart';
import 'presentation/l10n/timeago_l10n.dart';
import 'presentation/viewmodels/settings/notifier.dart';
import 'providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await configureDependencies();

  usePathUrlStrategy();

  final container = ProviderContainer();
  container.read(themeProvider.notifier).get();
  container.read(localeProvider.notifier).get();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
  });

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    timeago.setLocaleMessages(
      'default',
      TimeagoLocalization(),
    );

    timeago.setDefaultLocale(
      'default',
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.listen<ThemeState>(
      themeProvider,
      (previousState, nextState) {
        nextState.whenOrNull(
          failedToRetrieveSettings: (_) {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context).errorFailedToChangeTheme,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          },
        );
      },
    );

    ref.listen<LocaleState>(
      localeProvider,
      (previousState, nextState) {
        nextState.whenOrNull(
          failedToRetrieveSettings: (_) {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context).errorFailedToChangeLanguage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          },
        );
      },
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        return AppLocalizations.of(context).appName;
      },
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      locale: ref.watch(localeProvider).locale,
      theme: THEME.light,
      darkTheme: THEME.dark,
      themeMode: ref.watch(themeProvider).themeMode,
      routerConfig: getIt<GoRouter>(),
    );
  }
}
