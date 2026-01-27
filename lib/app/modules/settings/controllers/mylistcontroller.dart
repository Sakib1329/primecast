import 'package:get/get.dart';
import 'package:primecast/app/res/assets/asset.dart';

// Simple model to hold your data
class MediaItem {
  final String title;
  final String year;
  final String info;
  final String type; // 'Movie' or 'Series'
  final String genre;
  final String addedDate;
  final String imageUrl;

  MediaItem({
    required this.title,
    required this.year,
    required this.info,
    required this.type,
    required this.genre,
    required this.addedDate,
    required this.imageUrl,
  });
}

class MyListController extends GetxController {
  // Observable list of all items
  var allItems = <MediaItem>[].obs;

  // Observable for the current tab index
  var selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData() {
    allItems.assignAll([
      MediaItem(
        title: "The Last Kingdom",
        year: "2023",
        info: "4 Seasons",
        type: "Series",
        genre: "Action, Drama",
        addedDate: "Added 2 days ago",
        imageUrl: ImageAssets.img_jpg_4,
      ),
      MediaItem(
        title: "Breaking Boundaries",
        year: "2024",
        info: "2h 15m",
        type: "Movie",
        genre: "Thriller",
        addedDate: "Added 1 week ago",
        imageUrl: ImageAssets.img_jpg,
      ),
      MediaItem(
        title: "Dark Secrets",
        year: "2023",
        info: "2 Seasons",
        type: "Series",
        genre: "Mystery",
        addedDate: "Added 2 weeks ago",
        imageUrl: ImageAssets.img_jpg_1,
      ),
      MediaItem(
        title: "Cosmic Journey",
        year: "2024",
        info: "1h 58m",
        type: "Movie",
        genre: "Sci-Fi",
        addedDate: "Added 3 weeks ago",
        imageUrl: ImageAssets.img_jpg_3,
      ),
    ]);
  }

  // Logic to filter items based on the active tab
  List<MediaItem> get filteredItems {
    if (selectedTabIndex.value == 1) {
      return allItems.where((item) => item.type == 'Movie').toList();
    } else if (selectedTabIndex.value == 2) {
      return allItems.where((item) => item.type == 'Series').toList();
    }
    return allItems;
  }

  void removeItem(MediaItem item) {
    allItems.remove(item);
  }
}