import 'package:get_x/get.dart';

import '../modules/login_screen/login_binding.dart';
import '../modules/login_screen/login_view.dart';
import '../modules/pull_request/pull_request_binding.dart';
import '../modules/pull_request/pull_request_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.pullRequestScreen,
      page: () => PullRequestView(),
      binding: PullRequestBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}