// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/search_category.dart';

class SearchCategoryBoxTile extends StatelessWidget {
  final SearchCategory category;

  const SearchCategoryBoxTile({
    super.key,
    required this.category,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 150,
        maxHeight: 150,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(
                      category.icon,
                      size: 35,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: AutoSizeText(
                        category.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.push(
                      '/categories/${category.slug}',
                      extra: category.name,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
