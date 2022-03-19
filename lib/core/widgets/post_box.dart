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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../entities/post.dart';
import '../l10n/generated/l10n.dart';

class PostBox extends StatelessWidget {
  final Post post;

  const PostBox({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 155,
        maxHeight: 155,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
            child: Card(
              color: Theme.of(context).colorScheme.primary.withAlpha(20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(115, 10, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        post.title.length > 40
                            ? '${post.title.substring(0, 40)}...'
                            : post.title,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            post.categories[0].name,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .caption
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.date_range_rounded,
                              color: Color(0xFF999999),
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .dateFormat(post.date),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: SizedBox(
              height: 125,
              width: 125,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: post.image,
                  placeholder: (_, __) => Image.asset(
                    'assets/img/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (post.video != '')
            Positioned(
              left: 40,
              top: 40,
              child: Icon(
                Icons.play_circle_outline_rounded,
                color: Theme.of(context).colorScheme.background,
                size: 45,
              ),
            ),
        ],
      ),
    );
  }
}
