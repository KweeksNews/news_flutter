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

import '../../../../core/config/config.dart';
import '../../../../core/entities/state_exception.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/types/post_id_type.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../providers.dart';
import '../notifier/single_post_state.dart';
import '../widgets/html_content.dart';
import '../widgets/related_posts.dart';

class SinglePost extends ConsumerStatefulWidget {
  final String id;
  final PostIdType idType;

  const SinglePost({
    super.key,
    required this.id,
    required this.idType,
  });

  @override
  ConsumerState<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends ConsumerState<SinglePost> {
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
          final SinglePostState singlePostState = ref.watch(singlePostProvider);
          final bool savedPostState = ref.watch(savedPostProvider);

          if (singlePostState is SinglePostLoaded) {
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
                    '${singlePostState.post.title}\nhttps://${CONFIG.hostName}${singlePostState.post.slug}',
                  ),
                  child: const Icon(
                    Icons.share,
                  ),
                ),
                SpeedDialChild(
                  elevation: 1,
                  shape: const CircleBorder(),
                  onTap: () {
                    if (!savedPostState) {
                      ref.read(savedPostProvider.notifier).createPost(
                            post: PostModel(
                              id: singlePostState.post.id,
                              date: singlePostState.post.date,
                              slug: singlePostState.post.slug,
                              title: singlePostState.post.title,
                              content: '',
                              image: singlePostState.post.image,
                              video: singlePostState.post.video,
                              author: singlePostState.post.author,
                              categories: singlePostState.post.categories,
                              tags: const [],
                            ),
                          );
                    } else {
                      ref.read(savedPostProvider.notifier).deletePost(
                            postId: singlePostState.post.id,
                          );
                    }
                  },
                  child: Icon(
                    savedPostState
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                ),
              ],
            );
          } else {
            return const Nil();
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Builder(
          builder: (context) {
            final SinglePostState state = ref.watch(singlePostProvider);

            if (state is SinglePostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SinglePostLoaded) {
              ref.read(savedPostProvider.notifier).checkPostSaveStatus(
                    postId: state.post.id,
                  );

              if (state.post.video != '') {
                _playerController = YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                    state.post.video,
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
                      child: state.post.video != ''
                          ? YoutubePlayer(
                              controller: _playerController!,
                              actionsPadding: const EdgeInsets.all(10),
                              thumbnail: CachedNetworkImage(
                                imageUrl: state.post.image,
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
                                          Uri.parse(state.post.video))) {
                                        await launchUrl(
                                          Uri.parse(state.post.video),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              AppLocalizations.of(context)
                                                  .errorCannotOpenUrl(
                                                state.post.video,
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
                              imageUrl: state.post.image,
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
                        children: state.post.categories.map(
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
                        state.post.title,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
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
                        AppLocalizations.of(context)
                            .dateFormat(state.post.date),
                      ),
                    ),
                    HtmlContent(
                      data: state.post.content,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: state.post.tags.map(
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
                        tileColor:
                            Theme.of(context).colorScheme.primary.withAlpha(50),
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
                            state.post.author.avatar,
                          ),
                        ),
                        title: Text(
                          state.post.author.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                        ),
                        onTap: () {
                          context.push(
                            '/users/${state.post.author.slug}',
                            extra: state.post.author.slug,
                          );
                        },
                      ),
                    ),
                    if (state.post.tags.isNotEmpty)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: RelatedPosts(
                          postId: state.post.id,
                          tagsId: state.post.tags.map((d) => d.id).toList(),
                        ),
                      ),
                  ],
                ),
              );
            } else if (state is SinglePostException) {
              late StateException exception;

              if (state.type == StateExceptionType.failedToLoadData) {
                exception = StateException(
                  message: AppLocalizations.of(context).errorFailedToLoadData,
                  image: 'assets/img/error.png',
                );
              } else {
                exception = StateException(
                  message: AppLocalizations.of(context).errorGeneric,
                  image: 'assets/img/error.png',
                );
              }

              return ErrorIndicator(
                message: exception.message,
                image: exception.image,
                onTryAgain: () {
                  refresh();
                },
              );
            } else {
              return const Nil();
            }
          },
        ),
      ),
    );
  }
}
