import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:primecast/app/res/assets/asset.dart';
class MovieModel {
  final String title, category, imageUrl, rating;
  final String? description; // Add this
  final double? progress;
  final String? yearType;

  MovieModel({
    required this.title,
    required this.category,
    required this.imageUrl,
    this.description, // Add this
    this.rating = "8.0",
    this.progress,
    this.yearType,
  });
}
class Homecontroller extends GetxController{

  final RxInt currentIndex = 0.obs;
  final pageController = PageController();
  void changePage(int index) {
    currentIndex.value = index;
  }

  // New Section (Auto Slider)
  final List<MovieModel> newHeroList = [
    MovieModel(title: "The Last Kingdom", category: "Action • Drama • Fantasy", imageUrl: ImageAssets.img_jpg_2,description: "Experience the epic saga of warriors, kingdoms, and betrayal in this critically acclaimed series.",),
    MovieModel(title: "Cosmic Journey", category: "Sci-Fi • Adventure", imageUrl: ImageAssets.img_jpg,description: "Experience the epic saga of warriors, kingdoms, and betrayal in this critically acclaimed series.",),
  ];

  // Continue Watching (With Progress)
  final List<MovieModel> continueWatchingList = [
    MovieModel(title: "Cosmic Journey", category: "Sci-Fi", imageUrl: ImageAssets.img_jpg_2, progress: 0.7,rating: "8.5", yearType: "2023 • Series"),
    MovieModel(title: "Mystery House", category: "Thriller", imageUrl: ImageAssets.img_jpg_4, progress: 0.4,rating: "8.5", yearType: "2023 • Series"),
    MovieModel(title: "Breaking Boundaries", category: "Drama", imageUrl: ImageAssets.img_jpg_5, progress: 0.9,rating: "8.5", yearType: "2023 • Series"),
  ];

  // New Releases
  final List<MovieModel> newReleases = [
    MovieModel(title: "Neon Nights", category: "Action", imageUrl: ImageAssets.img_jpg_5, rating: "8.5", yearType: "2023 • Series"),
    MovieModel(title: "Silent Echo", category: "Horror", imageUrl: ImageAssets.img_jpg_4, rating: "7.2", yearType: "2024 • Movie"),
    MovieModel(title: "Love & Legend", category: "Romance", imageUrl: ImageAssets.img_jpg_3, rating: "8.1", yearType: "2023 • Series"),
  ];

  @override
  void onInit() {
    super.onInit();
    currentIndex.listen((index) {
      pageController.jumpToPage(index);
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}