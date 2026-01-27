import 'package:get/get.dart';
import 'package:primecast/app/res/assets/asset.dart';
class WatchItem {
  final String title;
  final String category;
  final String timeAgo;
  final String seasonEpisode;
  final String duration;
  final String imageUrl;
  final double progress; // 0.0 to 1.0

  WatchItem({
    required this.title,
    required this.category,
    required this.timeAgo,
    required this.seasonEpisode,
    required this.duration,
    required this.imageUrl,
    required this.progress,
  });

  bool get isCompleted => progress >= 1.0;
}
class WatchHistoryController extends GetxController {
  var historyList = <WatchItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    // Simulated data matching your screenshot
    historyList.assignAll([
      WatchItem(title: "The Last", category: "Action, Drama", timeAgo: "2 hours ago", seasonEpisode: "S1 E1", duration: "45 min", progress: 0.65, imageUrl: ImageAssets.img_jpg_4),
      WatchItem(title: "Breaking", category: "Drama", timeAgo: "Yesterday", seasonEpisode: "S2 E5", duration: "42 min", progress: 0.85, imageUrl: ImageAssets.img_jpg_3),
      WatchItem(title: "Cosmic Journey", category: "Sci-Fi", timeAgo: "2 days ago", seasonEpisode: "", duration: "2h 15min", progress: 1.0, imageUrl: ImageAssets.img_jpg_1),
      WatchItem(title: "Mystery House", category: "Mystery", timeAgo: "3 days ago", seasonEpisode: "S1 E3", duration: "38 min", progress: 0.45, imageUrl: ImageAssets.img_jpg_2),
    ]);
  }

  void removeItem(int index) => historyList.removeAt(index);
  void clearAll() => historyList.clear();
}