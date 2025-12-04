import 'package:flutter/cupertino.dart';
import 'package:get_x/get.dart';
import 'package:intl/intl.dart';

import '../../../core/storage_data.dart';
import '../../data/model/pull_request_model.dart';
import '../../data/service/network_service.dart';
import '../../routes/app_routes.dart';

class PullRequestController extends GetxController {
  final networkService = NetworkService();
  final prList = <PullRequestModel>[].obs;
  final status = Status.loading.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    fetchPullRequests();
    super.onInit();
  }

  void fetchPullRequests() async {
    try {
      status.value = Status.loading;
      final pullRequests = await networkService.getPullRequests();
      if (pullRequests.isNotEmpty) {
        prList.assignAll(pullRequests);
        status.value = Status.success;
      } else {
        status.value = Status.empty;
        errorMessage.value = 'No pull requests found';
      }
    } catch (e) {
      status.value = Status.error;
      errorMessage.value = 'Failed to load pull requests';
      debugPrint('Error fetching pull requests: $e');
    }
  }

  String formatDate(String? dateString) {
    if (dateString == null) return 'Unknown Date';
    try {
      return DateFormat('dd MMM yyyy, hh:mm a')
          .format(DateTime.parse(dateString).toLocal());
    } catch (e) {
      return 'Unknown Date';
    }
  }

  void logout() async {
    await StorageData.clearData();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

}

enum Status { loading, success, error,empty }