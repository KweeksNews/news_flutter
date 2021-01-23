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
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:nb_utils/nb_utils.dart';

abstract class NetworkUtils {
  static final _dioCacheManager = DioCacheManager(CacheConfig());
  static final Dio _dio = Dio()
    ..interceptors.add(_dioCacheManager.interceptor as Interceptor);

  const NetworkUtils();

  bool _isSuccessful(int code) {
    return code == 200 || code == 201;
  }

  Future<Response> getRequest(Uri apiUrl, Uri endPoint) async {
    if (await isNetworkAvailable()) {
      final Response response = await _dio.get(
        '$apiUrl$endPoint',
        options: buildCacheOptions(
          const Duration(days: 7),
          forceRefresh: true,
          options: Options(
            headers: {
              HttpHeaders.userAgentHeader:
                  'KweeksNews/1.0.0 (+com.kweeksnews.app)',
              HttpHeaders.cacheControlHeader: 'no-cache',
              HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
            },
          ),
        ),
      );
      return response;
    } else {
      throw NetworkException;
    }
  }

  Future<Response> postRequest(Uri apiUrl, Uri endPoint, Map request) async {
    if (await isNetworkAvailable()) {
      final Response response = await _dio.post(
        '$apiUrl$endPoint',
        options: Options(
          headers: {
            HttpHeaders.userAgentHeader:
                'KweeksNews/1.0.0 (+com.kweeksnews.app)',
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.cacheControlHeader: 'no-cache',
            HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
          },
        ),
        data: jsonEncode(request),
      );
      return response;
    } else {
      throw NetworkException;
    }
  }

  Future<Map> handleResponse(Response response) async {
    try {
      if (_isSuccessful(response.statusCode)) {
        final int status = response.statusCode;
        final Headers headers = response.headers;
        final dynamic body = response.data;
        return {
          'status': status,
          'headers': headers,
          'body': body,
        };
      } else {
        throw 'Request failed!';
      }
    } catch (error) {
      rethrow;
    }
  }
}

abstract class NetworkException implements Exception {
  const NetworkException();
}
