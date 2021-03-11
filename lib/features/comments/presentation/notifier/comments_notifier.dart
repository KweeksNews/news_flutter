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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/comment.dart';
import '../../domain/usecases/get_comments.dart';
import 'notifier.dart';

@injectable
class CommentsNotifier extends StateNotifier<CommentsState> {
  GetComments getComments;
  bool forceRefresh = false;
  String comment = '';

  CommentsNotifier({
    required this.getComments,
  }) : super(const CommentsLoading());

  Future<void> fetchPage(int postId, int pageKey, int fetched) async {
    final failureOrPosts = await getComments(
      postId: postId,
      pageKey: pageKey,
      forceRefresh: forceRefresh,
    );

    failureOrPosts.fold(
      (failure) {
        state = const CommentsError(
          message: 's',
        );
      },
      (commentList) {
        final int totalPosts = commentList.totalComments;
        final List<Comment> comments = commentList.comments;

        if (forceRefresh) {
          forceRefresh = false;
        }

        if (fetched + comments.length == totalPosts) {
          state = CommentsAppendLast(
            comments: comments,
          );
        } else {
          state = CommentsAppend(
            comments: comments,
            nextPageKey: pageKey + 1,
          );
        }
      },
    );
  }

  // Future<void> _sendComment() async {
  //   if (_formKey.currentState.validate()) {
  //     FocusScope.of(context).unfocus();
  //     _formKey.currentState.save();

  //     if (_name.isEmpty && _email.isEmpty) {
  //       showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext dialogContext) {
  //           return const IdentitySettingsDialog();
  //         },
  //       );
  //     }

  //     _flutterToast.showToast(
  //       gravity: ToastGravity.BOTTOM,
  //       toastDuration: const Duration(seconds: 2),
  //       child: Container(
  //         padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  //         decoration: BoxDecoration(
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(30),
  //           ),
  //           color: Theme.of(context).buttonColor,
  //         ),
  //         child: Text(
  //           'Mengirim komentar...',
  //           style: Theme.of(context).primaryTextTheme.headline6.copyWith(
  //                 color: Theme.of(context).iconTheme.color,
  //               ),
  //         ),
  //       ),
  //     );

  //     try {
  //       final Map result = await _wpApi.postComment(
  //         request: {
  //           'post': widget.postId,
  //           'author_email': _email,
  //           'author_name': _name,
  //           'content': _comment,
  //         },
  //       );

  //       if (result['status'] == 201) {
  //         _pagingController.refresh();
  //         _formKey.currentState.reset();
  //         _flutterToast.showToast(
  //           gravity: ToastGravity.BOTTOM,
  //           toastDuration: const Duration(seconds: 2),
  //           child: Container(
  //             padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  //             decoration: BoxDecoration(
  //               borderRadius: const BorderRadius.all(
  //                 Radius.circular(30),
  //               ),
  //               color: Theme.of(context).buttonColor,
  //             ),
  //             child: Text(
  //               'Komentar terkirim!',
  //               style: Theme.of(context).primaryTextTheme.headline6.copyWith(
  //                     color: Theme.of(context).iconTheme.color,
  //                   ),
  //             ),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       _flutterToast.showToast(
  //         gravity: ToastGravity.BOTTOM,
  //         toastDuration: const Duration(seconds: 2),
  //         child: Container(
  //           padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  //           decoration: BoxDecoration(
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(30),
  //             ),
  //             color: Theme.of(context).buttonColor,
  //           ),
  //           child: Text(
  //             'Gagal mengirim komentar!',
  //             style: Theme.of(context).primaryTextTheme.headline6.copyWith(
  //                   color: Theme.of(context).iconTheme.color,
  //                 ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
}
