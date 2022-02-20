// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_config.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RouteConfigCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// RouteConfig(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteConfig call({
    RouteAction? currentRouteAction,
    String? key,
    Map<String, String>? parameters,
    String? path,
    Map<String, String>? queryParameters,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRouteConfig.copyWith(...)`.
class _$RouteConfigCWProxyImpl implements _$RouteConfigCWProxy {
  final RouteConfig _value;

  const _$RouteConfigCWProxyImpl(this._value);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// RouteConfig(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteConfig call({
    Object? currentRouteAction = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
    Object? path = const $CopyWithPlaceholder(),
    Object? queryParameters = const $CopyWithPlaceholder(),
  }) {
    return RouteConfig(
      currentRouteAction: currentRouteAction == const $CopyWithPlaceholder()
          ? _value.currentRouteAction
          // ignore: cast_nullable_to_non_nullable
          : currentRouteAction as RouteAction?,
      key: key == const $CopyWithPlaceholder() || key == null
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      name: _value.name,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, String>?,
      path: path == const $CopyWithPlaceholder()
          ? _value.path
          // ignore: cast_nullable_to_non_nullable
          : path as String?,
      queryParameters: queryParameters == const $CopyWithPlaceholder()
          ? _value.queryParameters
          // ignore: cast_nullable_to_non_nullable
          : queryParameters as Map<String, String>?,
      template: _value.template,
    );
  }
}

extension $RouteConfigCopyWith on RouteConfig {
  /// Returns a callable class that can be used as follows: `instanceOfclass RouteConfig extends Equatable.name.copyWith(...)`.
  _$RouteConfigCWProxy get copyWith => _$RouteConfigCWProxyImpl(this);
}
