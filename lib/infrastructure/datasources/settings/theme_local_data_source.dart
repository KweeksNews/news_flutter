// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/error/exceptions.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeMode> getTheme();

  Future<ThemeMode> setTheme(ThemeMode mode);
}

@LazySingleton(as: ThemeLocalDataSource)
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final Box<dynamic> _box;

  ThemeLocalDataSourceImpl(
    @Named('settingsBox') this._box,
  );

  @override
  Future<ThemeMode> getTheme() async {
    final String? mode = _box.get('themeMode') as String?;

    switch (mode) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        throw ConfigException();
    }
  }

  @override
  Future<ThemeMode> setTheme(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.system:
        await _box.put('themeMode', 'system');

        return mode;
      case ThemeMode.light:
        await _box.put('themeMode', 'light');

        return mode;
      case ThemeMode.dark:
        await _box.put('themeMode', 'dark');

        return mode;
      default:
        throw ConfigException();
    }
  }
}
