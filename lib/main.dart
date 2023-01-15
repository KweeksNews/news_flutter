/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

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
