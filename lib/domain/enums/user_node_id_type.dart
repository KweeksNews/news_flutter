// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

enum UserNodeIdType {
  databaseId('DATABASE_ID'),
  email('EMAIL'),
  id('ID'),
  slug('SLUG'),
  uri('URI'),
  username('USERNAME');

  final String type;

  const UserNodeIdType(
    this.type,
  );

  @override
  String toString() => type;
}
