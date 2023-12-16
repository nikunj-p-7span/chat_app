// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:chat_app/module/authentication/screens/login_screen.dart'
    as _i2;
import 'package:chat_app/module/chat/screens/chat_screen.dart' as _i1;
import 'package:chat_app/module/detail/screen/messages_screen.dart' as _i3;
import 'package:chat_app/module/splash/splash_screen.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i1.ChatScreen()),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i2.LoginScreen()),
      );
    },
    MessagesRoute.name: (routeData) {
      final args = routeData.argsAs<MessagesRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(
            child: _i3.MessagesScreen(
          key: args.key,
          name: args.name,
          isOnline: args.isOnline,
          imageUrl: args.imageUrl,
          idTo: args.idTo,
          convoId: args.convoId,
        )),
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
/// [_i2.LoginScreen]
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
/// [_i3.MessagesScreen]
class MessagesRoute extends _i5.PageRouteInfo<MessagesRouteArgs> {
  MessagesRoute({
    _i6.Key? key,
    required String? name,
    required String? isOnline,
    required String? imageUrl,
    required String? idTo,
    required String? convoId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MessagesRoute.name,
          args: MessagesRouteArgs(
            key: key,
            name: name,
            isOnline: isOnline,
            imageUrl: imageUrl,
            idTo: idTo,
            convoId: convoId,
          ),
          initialChildren: children,
        );

  static const String name = 'MessagesRoute';

  static const _i5.PageInfo<MessagesRouteArgs> page =
      _i5.PageInfo<MessagesRouteArgs>(name);
}

class MessagesRouteArgs {
  const MessagesRouteArgs({
    this.key,
    required this.name,
    required this.isOnline,
    required this.imageUrl,
    required this.idTo,
    required this.convoId,
  });

  final _i6.Key? key;

  final String? name;

  final String? isOnline;

  final String? imageUrl;

  final String? idTo;

  final String? convoId;

  @override
  String toString() {
    return 'MessagesRouteArgs{key: $key, name: $name, isOnline: $isOnline, imageUrl: $imageUrl, idTo: $idTo, convoId: $convoId}';
  }
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
