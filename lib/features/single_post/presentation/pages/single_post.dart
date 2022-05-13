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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nil/nil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/config/config.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/types/post_id_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../providers.dart';
import '../notifier/single_post_state.dart';
import '../widgets/html_content.dart';
import '../widgets/related_posts.dart';

class SinglePost extends ConsumerStatefulWidget {
  final String id;
  final PostIdType idType;

  const SinglePost({
    required this.id,
    required this.idType,
    Key? key,
  }) : super(key: key);

  @override
  _SinglePostState createState() => _SinglePostState();
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
              widget.id,
              widget.idType,
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
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
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
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              children: <SpeedDialChild>[
                SpeedDialChild(
                  elevation: 0,
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  onTap: () => Share.share(
                    '${singlePostState.post.title}\nhttps://${CONFIG.hostName}${singlePostState.post.slug}',
                  ),
                  child: const Icon(
                    Icons.share,
                  ),
                ),
                SpeedDialChild(
                  elevation: 0,
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  onTap: () {
                    if (!savedPostState) {
                      ref.read(savedPostProvider.notifier).createPost(
                            PostModel(
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
                            singlePostState.post.id,
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
        child: Consumer(
          builder: (context, watch, child) {
            final SinglePostState state = ref.watch(singlePostProvider);

            if (state is SinglePostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SinglePostLoaded) {
              ref.read(savedPostProvider.notifier).checkPost(state.post.id);

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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 10, 0),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: RemainingDuration(),
                                ),
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                  icon: const FaIcon(
                                    FontAwesomeIcons.externalLinkAlt,
                                  ),
                                  iconSize: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.fontSize,
                                  onPressed: () async {
                                    if (await canLaunch(state.post.video)) {
                                      await launch(state.post.video);
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 0,
                        children: state.post.categories.map(
                          (d) {
                            return ActionChip(
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
                              // TODO add action to open category page
                              onPressed: () {},
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        state.post.title,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Text(
                        AppLocalizations.of(context)
                            .dateFormat(state.post.date),
                      ),
                    ),
                    HtmlContent(
                      data: state.post.content,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 0,
                        children: state.post.tags.map(
                          (d) {
                            return ActionChip(
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
                              // TODO add action to open tag page
                              onPressed: () {},
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListTile(
                        tileColor:
                            Theme.of(context).colorScheme.primary.withAlpha(20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                        // TODO add action to open author profile
                        onTap: () {},
                      ),
                    ),
                    if (state.post.tags.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: RelatedPosts(
                          postId: state.post.id,
                          tagsId: state.post.tags.map((d) => d.id).toList(),
                        ),
                      ),
                  ],
                ),
              );
            } else if (state is SinglePostError) {
              return ErrorIndicator(
                message: state.message,
                image: 'assets/img/error.png',
                onTryAgain: () {
                  ref.read(singlePostProvider.notifier).fetchPost(
                        widget.id,
                        widget.idType,
                      );
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
