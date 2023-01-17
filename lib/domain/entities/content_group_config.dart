// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class ContentGroupConfig extends Equatable {
  final String name;
  final String id;

  const ContentGroupConfig({
    required this.name,
    required this.id,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
    ];
  }
}
