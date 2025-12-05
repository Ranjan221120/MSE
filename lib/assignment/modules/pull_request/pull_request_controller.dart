import 'package:flutter/cupertino.dart';
import 'package:get_x/get.dart';
import 'package:intl/intl.dart';

import '../../../core/storage_data.dart';
import '../../data/model/pull_request_model.dart';
import '../../data/service/connectivity_service.dart';
import '../../data/service/network_service.dart';
import '../../routes/app_routes.dart';

class PullRequestController extends GetxController {
  final networkService = NetworkService();
  final connectivityService = ConnectivityService();
  final prList = <PullRequestModel>[].obs;
  final status = Status.loading.obs;
  final errorMessage = ''.obs;
  final isConnected = true.obs;

  @override
  void onInit() {
    connectivityService.getConnectionStream().listen((isOnline) {
      isConnected.value = isOnline;
      debugPrint('Connection status: ${isOnline ? 'Online' : 'Offline'}');
      
      if (isOnline && status.value == Status.checkInternet) {
        fetchPullRequests();
      }
    });
    
    fetchPullRequests();
    super.onInit();
  }

  void fetchPullRequests() async {
    try {
      bool hasConnection = await connectivityService.hasInternetConnection();
      isConnected.value = hasConnection;

      if (!hasConnection) {
        status.value = Status.checkInternet;
        errorMessage.value = 'No internet connection. Please check your network.';
        debugPrint('No internet connection');
        return;
      }

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

enum Status { loading, success, error,empty,checkInternet}