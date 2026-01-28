import 'package:get/get.dart';

import '../../../res/assets/asset.dart';

class MusicModel {
  final String title, artist, views, duration, image;
  MusicModel({required this.title, required this.artist, required this.views, required this.duration, required this.image});
}

class MusicController extends GetxController {
  var selectedTab = 0.obs;
  var currentCarouselIndex = 0.obs; // Track slider position

  final List<String> categories = ["Pop", "Rock", "Electronic", "Hip Hop", "Jazz", "Classical"];

  // Featured Data for Carousel
  final List<MusicModel> featuredVideos = [
    MusicModel(title: "Neon Dreams", artist: "The Midnight", views: "2.5M views", duration: "3:45", image: ImageAssets.img_jpg_4),
    MusicModel(title: "Midnight City", artist: "M83", views: "1.2M views", duration: "4:03", image: ImageAssets.img_jpg_3),
    MusicModel(title: "Electric Youth", artist: "College", views: "900K views", duration: "3:20", image: ImageAssets.img_jpg_2),
  ];

  final List<MusicModel> trendingMusic = [
    MusicModel(title: "Electric Soul", artist: "Synth Wave", views: "1.8M views", duration: "4:12", image: ImageAssets.img_jpg_4),
    MusicModel(title: "City Lights", artist: "Urban Beats", views: "3.2M views", duration: "3:50", image: ImageAssets.img_jpg_2),
  ];

  final List<MusicModel> newReleases = [
    MusicModel(title: "Midnight Drive", artist: "Retro Vibes", views: "856K views", duration: "3:52", image: ImageAssets.img_jpg_4),
    MusicModel(title: "Ocean Waves", artist: "Chill Beats", views: "1.2M views", duration: "4:05", image: ImageAssets.img_jpg_2),
  ];

  void changeTab(int index) => selectedTab.value = index;
}