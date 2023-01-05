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

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostListTileLoading extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const PostListTileLoading({
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
            minHeight: 125,
            maxHeight: 125,
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
