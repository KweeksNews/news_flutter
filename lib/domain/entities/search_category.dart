// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchCategory extends Equatable {
  final int id;
  final String slug;
  final String name;
  final IconData icon;

  const SearchCategory({
    required this.id,
    required this.slug,
    required this.name,
    required this.icon,
  });

  @override
  List<Object> get props {
    return [
      id,
      slug,
      name,
      icon,
    ];
  }
}
