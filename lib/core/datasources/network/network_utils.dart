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

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../../error/exceptions.dart';

abstract class NetworkUtils {
  final InternetConnectionChecker connectionChecker;
  final Dio dio;
  final DioCacheManager dioCacheManager;

  NetworkUtils({
    required this.connectionChecker,
    required this.dio,
    required this.dioCacheManager,
  });

  bool _isSuccessful(int code) {
    return code == 200 || code == 201;
  }

  Future<bool> _isNetworkAvailable() => connectionChecker.hasConnection;

  Future<Response> getRequest({
    required Uri apiUrl,
    required Uri endPoint,
    bool? forceRefresh,
  }) async {
    if (await _isNetworkAvailable()) {
      dio.interceptors.add(dioCacheManager.interceptor as Interceptor);
      final Response response = await dio.get(
        '$apiUrl$endPoint',
        options: buildCacheOptions(
          const Duration(days: 3),
          forceRefresh: forceRefresh ?? false,
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

  Future<Response> postRequest({
    required Uri apiUrl,
    required Uri endPoint,
    required Map request,
  }) async {
    if (await _isNetworkAvailable()) {
      final Response response = await dio.post(
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

  Future<Response> handleResponse(Response response) async {
    try {
      if (_isSuccessful(response.statusCode!)) {
        return response;
      } else {
        throw RequestException;
      }
    } catch (error) {
      rethrow;
    }
  }
}
