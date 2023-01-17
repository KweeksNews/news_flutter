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

import '../../../../domain/entities/post.dart';

class PostBox extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostBox({
    super.key,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      margin: EdgeInsets.zero,
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
                        labelPadding: const EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
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
