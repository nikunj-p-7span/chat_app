import 'package:auto_route/auto_route.dart';
import 'package:chat_app/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: ChatRoute.page,
        ),
      ];
}
