// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostBoxTileLoading extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const PostBoxTileLoading({
    super.key,
    this.margin,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.surface.withAlpha(20),
        period: const Duration(milliseconds: 1000),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 300,
            maxHeight: 300,
          ),
          child: const SizedBox.expand(
            child: Card(
              margin: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
