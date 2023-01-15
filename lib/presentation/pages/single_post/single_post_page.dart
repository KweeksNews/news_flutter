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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/config.dart';
import '../../../domain/enums/post_id_type.dart';
import '../../../providers.dart';
import '../../l10n/generated/l10n.dart';
import '../../viewmodels/single_post/single_post_state.dart';
import '../shared/widgets/error_indicator.dart';
import 'widgets/html_content.dart';
import 'widgets/related_posts.dart';

class SinglePostPage extends ConsumerStatefulWidget {
  final String id;
  final PostIdType idType;

  const SinglePostPage({
    super.key,
    required this.id,
    required this.idType,
  });

  @override
  ConsumerState<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends ConsumerState<SinglePostPage> {
  YoutubePlayerController? _playerController;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(singlePostProvider.notifier).fetchPost(
              id: widget.id,
              idType: widget.idType,
            );
      },
    );
  }

  @override
  void deactivate() {
    super.deactivate();

    _playerController?.pause();
  }

  @override
  void dispose() {
    super.dispose();

    _playerController?.dispose();
  }

  void refresh() {
    ref.read(singlePostProvider.notifier).fetchPost(
          id: widget.id,
          idType: widget.idType,
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<CircleBorder>(
                    const CircleBorder(),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final SinglePostState state = ref.watch(singlePostProvider);

          return state.maybeWhen(
            loaded: (post) {
              final bool state = ref.watch(savedPostProvider);

              ref.read(savedPostProvider.notifier).checkPostSaveStatus(
                    postId: post.id,
                  );

              return SpeedDial(
                elevation: 0,
                spacing: 3,
                spaceBetweenChildren: 2,
                icon: Icons.menu,
                activeIcon: Icons.close,
                renderOverlay: false,
                children: <SpeedDialChild>[
                  SpeedDialChild(
                    elevation: 1,
                    shape: const CircleBorder(),
                    onTap: () => Share.share(
                      '${post.title}\nhttps://${CONFIG.hostName}${post.slug}',
                    ),
                    child: const Icon(
                      Icons.share,
                    ),
                  ),
                  SpeedDialChild(
                    elevation: 1,
                    shape: const CircleBorder(),
                    onTap: () {
                      if (!state) {
                        ref.read(savedPostProvider.notifier).createPost(
                              post: post,
                            );
                      } else {
                        ref.read(savedPostProvider.notifier).deletePost(
                              postId: post.id,
                            );
                      }
                    },
                    child: Icon(
                      state
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                    ),
                  ),
                ],
              );
            },
            orElse: () {
              return const Nil();
            },
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Builder(
          builder: (context) {
            final SinglePostState state = ref.watch(singlePostProvider);

            return state.when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loaded: (post) {
                if (post.video.isNotEmpty) {
                  _playerController = YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(
                      post.video,
                    )!,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      loop: true,
                      enableCaption: false,
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: post.video.isNotEmpty
                            ? YoutubePlayer(
                                controller: _playerController!,
                                actionsPadding: const EdgeInsets.all(10),
                                thumbnail: CachedNetworkImage(
                                  imageUrl: post.image,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/img/placeholder.png',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                                bottomActions: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: CurrentPosition(),
                                  ),
                                  ProgressBar(
                                    isExpanded: true,
                                    colors: ProgressBarColors(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withAlpha(90),
                                      playedColor:
                                          Theme.of(context).colorScheme.primary,
                                      bufferedColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withAlpha(150),
                                      handleColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RemainingDuration(),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      right: 5,
                                    ),
                                    child: IconButton(
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.open_in_new_rounded,
                                      ),
                                      iconSize: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.fontSize,
                                      onPressed: () async {
                                        if (await canLaunchUrl(
                                            Uri.parse(post.video))) {
                                          await launchUrl(
                                            Uri.parse(post.video),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppLocalizations.of(context)
                                                    .errorCannotOpenUrl(
                                                  post.video,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : CachedNetworkImage(
                                imageUrl: post.image,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/placeholder.png',
                                  fit: BoxFit.fitWidth,
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: post.categories.map(
                            (d) {
                              return ActionChip(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                label: Text(
                                  d.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                pressElevation: 2,
                                onPressed: () {
                                  context.push(
                                    '/categories/${d.slug}',
                                    extra: d.name,
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          post.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          AppLocalizations.of(context).dateFormat(post.date),
                        ),
                      ),
                      HtmlContent(
                        data: post.content,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: post.tags.map(
                            (d) {
                              return ActionChip(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                label: Text(
                                  d.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                pressElevation: 2,
                                onPressed: () {
                                  context.push(
                                    '/tags/${d.slug}',
                                    extra: d.name,
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ListTile(
                          tileColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            15,
                            10,
                            15,
                            10,
                          ),
                          leading: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              post.author.avatar,
                            ),
                          ),
                          title: Text(
                            post.author.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward,
                          ),
                          onTap: () {
                            context.push(
                              '/users/${post.author.slug}',
                              extra: post.author.slug,
                            );
                          },
                        ),
                      ),
                      if (post.tags.isNotEmpty)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: RelatedPosts(
                            postId: post.id,
                            tagsId: post.tags.map((d) => d.id).toList(),
                          ),
                        ),
                    ],
                  ),
                );
              },
              failedToLoadData: () {
                return ErrorIndicator(
                  message: AppLocalizations.of(context).errorFailedToLoadData,
                  image: 'assets/img/error.png',
                  onTryAgain: () {
                    refresh();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
