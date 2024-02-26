import 'package:auto_route/auto_route.dart';
import 'auto_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: "/homePage",
        ),
        AutoRoute(
          page: LoginORregister.page,
          path: "/login",
        ),
        AutoRoute(page: LoadingRoute.page, path: "/loading", initial: true),
        AutoRoute(
          page: ListRoute.page,
          path: "/list",
        ),
        AutoRoute(page: Register.page, path: "/register")
      ];
}
