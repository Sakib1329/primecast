import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:primecast/app/res/assets/asset.dart';

enum NotificationType { episode, download, offer, system }

class NotificationModel {
  final String title;
  final String message;
  final String time;
  final String? imageUrl; // For the movie/episode thumbnail
  final NotificationType type;
  bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    this.imageUrl,
    required this.type,
    this.isRead = false,
  });
}

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[
    NotificationModel(
      title: "New Episode Available",
      message: "The Last Kingdom S4 E8 is now streaming",
      time: "5m ago",
      type: NotificationType.episode,
      imageUrl: ImageAssets.img_jpg_3,
    ),
    NotificationModel(
      title: "Download Complete",
      message: "Breaking Boundaries is ready, might like 'Dark Secrets'",
      time: "3h ago",
      type: NotificationType.download,
      imageUrl: ImageAssets.img_jpg_3,
      isRead: true,
    ),
    NotificationModel(
      title: "Exclusive Offer",
      message: "Upgrade to Premium and get 30% off for 6 months",
      time: "3d ago",
      type: NotificationType.offer,
      imageUrl: ImageAssets.img_jpg_3,
      isRead: false,
    ),
    NotificationModel(
      title: "New Season Coming Soon",
      message: "Cosmic Journey Season 2 arrives next week",
      time: "2d ago",
      type: NotificationType.system,
      imageUrl: ImageAssets.img_jpg_3,
      isRead: true, // This one won't have the green dot
    ),
  ].obs;

  void markAllAsRead() {
    for (var n in notifications) {
      n.isRead = true;
    }
    notifications.refresh();
  }
}