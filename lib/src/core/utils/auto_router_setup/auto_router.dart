import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/src/core/utils/auto_router_setup/auto_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: HistoryRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: InsightsRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: GraphRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: MedicationsRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: SettingsRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: CreateRecordRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: RemindersRoute.page,
          guards: [AuthGuard()],
        ),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true); // Allow navigation while wrapped in AuthWrapper
  }
}
