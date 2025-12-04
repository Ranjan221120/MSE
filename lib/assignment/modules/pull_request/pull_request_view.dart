import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:shimmer/shimmer.dart';

import 'pull_request_controller.dart';

class PullRequestView extends GetView<PullRequestController> {
  const PullRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Pull Requests'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.status.value == Status.loading) {
          return const PullRequestLoadingView();
        } else if (controller.status.value == Status.empty) {
          return emptyWidget();
        } else if (controller.status.value == Status.error) {
          return errorWidget();
        } else {
          return prListWidget();
        }
      }),
    );
  }

  Widget emptyWidget() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.fetchPullRequests();
      },
      child: ListView(
        children: [
          Container(
            height: Get.height - 100,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.indeterminate_check_box_rounded,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(controller.errorMessage.value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget errorWidget() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.fetchPullRequests();
      },
      child: ListView(
        children: [
          Container(
            height: Get.height - 100,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 5),
                Text(controller.errorMessage.value, style: const TextStyle()),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.fetchPullRequests,
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(5.0),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget prListWidget() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.fetchPullRequests();
      },
      child: ListView.builder(
        itemCount: controller.prList.length,
        itemBuilder: (context, index) {
          final pr = controller.prList[index];
          final date = controller.formatDate(pr.createdAt);
          return AnimationList(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                isThreeLine: true,
                title: Text((pr.title ?? '').capitalize),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((pr.body ?? '').isNotEmpty)
                      Text(pr.body ?? '', style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(
                      'By ${pr.author ?? 'Unknown'}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                trailing: Text(date),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PullRequestLoadingView extends StatelessWidget {
  const PullRequestLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                isThreeLine: true,
                title: Container(
                  width: Get.width,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Container(
                      width: Get.width,
                      height: 14.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      width: 100.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 50.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimationList extends StatelessWidget {
  final Widget child;
  const AnimationList({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
