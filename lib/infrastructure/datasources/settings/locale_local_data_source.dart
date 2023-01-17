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

abstract class LocaleLocalDataSource {
  Future<Locale> getLocale();

  Future<Locale> setLocale(String languageCode);
}

@LazySingleton(as: LocaleLocalDataSource)
class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  final Box<dynamic> _box;

  LocaleLocalDataSourceImpl(
    @Named('settingsBox') this._box,
  );

  @override
  Future<Locale> getLocale() async {
    final String? languageCode = _box.get('languageCode') as String?;

    switch (languageCode) {
      case 'en':
      case 'id':
        return Locale(languageCode!);
      default:
        throw ConfigException();
    }
  }

  @override
  Future<Locale> setLocale(
    String languageCode,
  ) async {
    switch (languageCode) {
      case 'en':
      case 'id':
        await _box.put('languageCode', languageCode);

        return Locale(languageCode);
      default:
        throw ConfigException();
    }
  }
}
