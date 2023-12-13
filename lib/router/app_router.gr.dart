// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:chat_app/module/authentication/screens/login_screen.dart'
    as _i3;
import 'package:chat_app/module/chat/screens/chat_screen.dart' as _i1;
import 'package:chat_app/module/detail/screen/detail_screen.dart' as _i2;
import 'package:chat_app/module/splash/splash_screen.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ChatScreen(),
      );
    },
    DetailRoute.name: (routeData) {
      final args = routeData.argsAs<DetailRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DetailScreen(
          key: args.key,
          name: args.name,
          isOnline: args.isOnline,
          imageUrl: args.imageUrl,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i3.LoginScreen()),
      );
    },
    SplashRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatScreen]
class ChatRoute extends _i5.PageRouteInfo<void> {
  const ChatRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DetailScreen]
class DetailRoute extends _i5.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i6.Key? key,
    required String? name,
    required String? isOnline,
    required String? imageUrl,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            name: name,
            isOnline: isOnline,
            imageUrl: imageUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static const _i5.PageInfo<DetailRouteArgs> page =
      _i5.PageInfo<DetailRouteArgs>(name);
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.name,
    required this.isOnline,
    required this.imageUrl,
  });

  final _i6.Key? key;

  final String? name;

  final String? isOnline;

  final String? imageUrl;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, name: $name, isOnline: $isOnline, imageUrl: $imageUrl}';
  }
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
