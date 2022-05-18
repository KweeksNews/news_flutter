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

class PostBoxTile extends StatelessWidget {
  final Post post;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const PostBoxTile({
    required this.post,
    this.margin,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 300,
          maxHeight: 300,
        ),
        child: Card(
          margin: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: AutoSizeText(
                                post.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                minFontSize: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .fontSize!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Chip(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  labelPadding:
                                      const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  label: Text(
                                    post.categories[0].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
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
                                        style:
                                            Theme.of(context).textTheme.caption,
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
                  ],
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
        ),
      ),
    );
  }
}
