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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../entities/post.dart';

class PostBox extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostBox({
    required this.post,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: Theme.of(context).colorScheme.primary.withAlpha(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              height: 200,
              width: double.infinity,
              imageUrl: post.image,
              placeholder: (_, __) => Image.asset(
                'assets/img/placeholder.png',
                fit: BoxFit.cover,
              ),
              errorWidget: (_, __, ___) => Image.asset(
                'assets/img/placeholder.png',
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const <double>[
                    0.1,
                    0.6,
                  ],
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.background.withAlpha(170),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      post.title,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                      minFontSize:
                          Theme.of(context).textTheme.subtitle1!.fontSize!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Chip(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        labelPadding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        label: Text(
                          post.categories[0].name,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Timeago(
                            date: post.date,
                            builder: (_, value) => Text(
                              value,
                              style: Theme.of(context).textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
