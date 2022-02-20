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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:injectable/injectable.dart';

import '../config/config.dart';
import '../error/exceptions.dart';
import '../models/post_list_model.dart';
import '../models/post_model.dart';

abstract class WPRemoteDataSource {
  const WPRemoteDataSource();

  Future<PostListModel> getPosts({
    required Map<String, String> parameters,
    required bool forceRefresh,
  });

  Future<PostModel> getPost({
    required Map<String, String> parameters,
    required bool forceRefresh,
  });
}

@LazySingleton(as: WPRemoteDataSource)
class WPRemoteDataSourceImpl extends WPRemoteDataSource {
  final Uri _apiUrl = Uri(
    scheme: 'https',
    host: CONFIG.hostName,
    path: 'wp-json/',
  );
  final Dio _dio;

  WPRemoteDataSourceImpl(
    this._dio,
  );

  bool _isSuccessful(int code) {
    return code == 200 || code == 201 || code == 304;
  }

  Future<Response<dynamic>> _getRequest({
    required Uri apiUrl,
    required Uri endPoint,
    required bool forceRefresh,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        '$apiUrl$endPoint',
        options: CONFIG.cacheOptions
            .copyWith(
              policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
            )
            .toOptions(),
      );

      return response;
    } catch (error) {
      throw NetworkException();
    }
  }

  Future<Response<dynamic>> _postRequest({
    required Uri apiUrl,
    required Uri endPoint,
    required Map<String, dynamic> request,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '$apiUrl$endPoint',
        data: jsonEncode(request),
      );

      return response;
    } catch (error) {
      throw NetworkException();
    }
  }

  Future<Response<dynamic>> _handleResponse(
    Response<dynamic> response,
  ) async {
    try {
      if (_isSuccessful(response.statusCode!)) {
        return response;
      } else {
        throw RequestException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PostListModel> getPosts({
    required Map<String, String> parameters,
    required bool forceRefresh,
  }) async {
    try {
      final Uri payload = Uri.parse(
        Uri.decodeFull(
          Uri(
            path: 'wp/v2/posts',
            queryParameters: parameters,
          ).toString(),
        ),
      );

      return PostListModel.fromApiResponse(
        await _handleResponse(
          await _getRequest(
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

  @override
  Future<PostModel> getPost({
    required Map<String, String> parameters,
    required bool forceRefresh,
  }) async {
    try {
      final Uri payload = Uri.parse(
        Uri.decodeFull(
          Uri(path: 'wp/v2/posts', queryParameters: parameters).toString(),
        ),
      );

      return PostModel.fromApiResponse(
        await _handleResponse(
          await _getRequest(
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
}
