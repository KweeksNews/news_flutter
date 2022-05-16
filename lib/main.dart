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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/config/theme.dart';
import 'core/l10n/generated/l10n.dart';
import 'core/l10n/timeago_l10n.dart';
import 'firebase_options.dart';
import 'injection.dart';
import 'providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await configureDependencies();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
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

    Future.delayed(
      Duration.zero,
      () {
        ref.read(themeProvider.notifier).get();
        ref.read(localeProvider.notifier).get();
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final ThemeMode themeState = ref.watch(themeProvider);
    final Locale localeState = ref.watch(localeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) {
        return AppLocalizations.of(context).appName;
      },
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      locale: localeState,
      theme: THEME.light,
      darkTheme: THEME.dark,
      themeMode: themeState,
      routerDelegate: getIt<RouterDelegate<Uri>>(
        instanceName: 'rootRouterDelegate',
      ),
      routeInformationParser: getIt<RouteInformationParser<Uri>>(),
      backButtonDispatcher: getIt<RootBackButtonDispatcher>(),
    );
  }
}
