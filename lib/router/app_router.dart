import 'package:auto_route/auto_route.dart';
import 'package:chat_app/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
          path: '/'
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login'
        ),
        AutoRoute(
          page: ChatRoute.page,
          path: '/chat',
          children: [
            AutoRoute(
              page: DetailRoute.page,
              path: 'detail',
            )
          ],
        ),
        AutoRoute(
          page: DetailRoute.page,
          path: '/detail',
        )
      ];
}
