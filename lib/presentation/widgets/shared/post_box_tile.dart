// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../../domain/entities/post.dart';

class PostBoxTile extends StatelessWidget {
  final Post post;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const PostBoxTile({
    super.key,
    required this.post,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: margin,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 300,
          maxHeight: 300,
        ),
        child: Card(
          margin: EdgeInsets.zero,
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
                                  labelPadding: const EdgeInsets.only(
                                    left: 3,
                                    right: 3,
                                  ),
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
