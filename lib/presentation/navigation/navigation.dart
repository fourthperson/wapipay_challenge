import 'package:auto_route/auto_route.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';

@AutoRouterConfig()
class WapiPayRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: PinRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}
