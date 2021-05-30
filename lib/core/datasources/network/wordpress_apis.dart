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

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../config/site.dart';
import '../../models/comment_list_model.dart';
import '../../models/post_list_model.dart';
import '../../models/post_content_model.dart';
import 'network_utils.dart';

@lazySingleton
class WpApi extends NetworkUtils {
  final Uri _apiUrl = Uri(
    scheme: 'https',
    host: siteHostName,
    path: 'wp-json/',
  );

  WpApi({
    required InternetConnectionChecker connectionChecker,
    required Dio dio,
    required DioCacheManager dioCacheManager,
  }) : super(
          connectionChecker: connectionChecker,
          dio: dio,
          dioCacheManager: dioCacheManager,
        );

  Future<PostListModel> getPosts({
    required Map<String, String> request,
    bool? forceRefresh,
  }) async {
    try {
      final Uri payload = Uri.parse(
        Uri.decodeFull(
          Uri(
            path: 'wp/v2/posts',
            queryParameters: request,
          ).toString(),
        ),
      );
      return PostListModel.fromApiJson(
        await handleResponse(
          await getRequest(
            apiUrl: _apiUrl,
            endPoint: payload,
            forceRefresh: forceRefresh,
          ),
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<SinglePostModel> getPost({
    required int id,
    required Map<String, String> request,
    bool? forceRefresh,
  }) async {
    try {
      final Uri payload = Uri.parse(
        Uri.decodeFull(
          Uri(
            path: 'wp/v2/posts/$id',
            queryParameters: request,
          ).toString(),
        ),
      );
      return SinglePostModel.fromApiJson(
        await handleResponse(
          await getRequest(
            apiUrl: _apiUrl,
            endPoint: payload,
            forceRefresh: forceRefresh,
          ),
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<CommentListModel> getComments({
    required Map<String, String> request,
    bool? forceRefresh,
  }) async {
    try {
      final Uri payload = Uri.parse(
        Uri.decodeFull(
          Uri(
            path: 'wp/v2/comments',
            queryParameters: request,
          ).toString(),
        ),
      );
      return CommentListModel.fromResponse(
        await handleResponse(
          await getRequest(
            apiUrl: _apiUrl,
            endPoint: payload,
            forceRefresh: forceRefresh,
          ),
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> postComment({required Map request}) async {
    try {
      final Uri path = Uri(path: 'wp/v2/comments');
      return handleResponse(
        await postRequest(
          apiUrl: _apiUrl,
          endPoint: path,
          request: request,
        ),
      );
    } catch (error) {
      rethrow;
    }
  }
}
