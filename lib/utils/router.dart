import 'package:auto_route/auto_route.dart';
import 'package:taiwan_superzzle/feature/home/home_screen.dart';
import 'package:taiwan_superzzle/feature/settings/settings_screen.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: SuperzzleRoute.page),
      ];
}
