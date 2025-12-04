// ignore_for_file: deprecated_member_use

import 'package:get_x/get.dart';

import 'pull_request_controller.dart';

class PullRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PullRequestController>(() => PullRequestController());
  }
}