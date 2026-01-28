import 'package:get/get.dart';

import '../../../res/assets/asset.dart';
import 'home_controller.dart';
class ContentModel {
  final String title, rating, year, ageRating, durationOrSeasons, description;
  final List<String> genres;
  final List<String> cast;
  final bool isSeries;
  final String imageUrl;

  ContentModel({
    required this.title, required this.rating, required this.year,
    required this.ageRating, required this.durationOrSeasons,
    required this.description, required this.genres, required this.cast,
    required this.isSeries, required this.imageUrl,
  });

  // Factory to convert Home Model to Detail Model
  factory ContentModel.fromMovieModel(MovieModel movie) {
    bool isSeries = movie.yearType?.toLowerCase().contains("series") ?? true;
    return ContentModel(
      title: movie.title,
      rating: movie.rating,
      year: movie.yearType?.split("•").first.trim() ?? "2024",
      ageRating: "TV-MA",
      durationOrSeasons: isSeries ? "4 Seasons" : "124 min",
      description: movie.description ?? "An epic tale of warriors and kingdoms in a world of magic and mystery.",
      genres: movie.category.split("•").map((e) => e.trim()).toList(),
      cast: ["Alexander Dreymon", "Emily Cox", "David Dawson"],
      isSeries: isSeries,
      imageUrl: movie.imageUrl,
    );
  }
}


class DetailsController extends GetxController {
  final ContentModel content;
  DetailsController(this.content);

  var selectedSeason = 1.obs;

  // Reactive lists separated by type
  final RxList<EpisodeModel> episodes = <EpisodeModel>[].obs;
  final RxList<RecommendedMovieModel> recommendations = <RecommendedMovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (content.isSeries) {
      _loadEpisodesForSeason(1);
    } else {
      _loadRecommendations();
    }
  }

  // Used for Movies
  void _loadRecommendations() {
    recommendations.assignAll([
      RecommendedMovieModel(
        title: "The Witcher",
        rating: "4.8",
        imageUrl: ImageAssets.img_jpg,
        category: "Action • Fantasy",
        year: "2023",
      ),
      RecommendedMovieModel(
        title: "Shadow and Bone",
        rating: "4.5",
        imageUrl: ImageAssets.img_jpg_2,
        category: "Adventure • Magic",
        year: "2021",
      ),
      RecommendedMovieModel(
        title: "The Last Kingdom",
        rating: "4.9",
        imageUrl: ImageAssets.img_jpg_3,
        category: "History • Drama",
        year: "2022",
      ),
    ]);
  }

  // Used for Series
  void _loadEpisodesForSeason(int season) {
    selectedSeason.value = season;
    episodes.assignAll([
      EpisodeModel(
          id: 1,
          title: "The Beginning", // Removed S$season from title for cleaner look
          duration: "45 min",
          description: "The journey begins with an unexpected encounter.",
          imageUrl: ImageAssets.img_jpg_2
      ),
      EpisodeModel(
          id: 2,
          title: "Rising Tensions",
          duration: "42 min",
          description: "Secrets are revealed as the plot thickens.",
          imageUrl: ImageAssets.img_jpg
      ),
      EpisodeModel(
          id: 3,
          title: "The Crossroads",
          duration: "50 min",
          description: "Decisions must be made that will change everything.",
          imageUrl: ImageAssets.img_jpg_4
      ),
    ]);
  }

  void changeSeason(int season) {
    _loadEpisodesForSeason(season);
  }
}

// Ensure these models exist in your file
class RecommendedMovieModel {
  final String title, rating, imageUrl, category, year;
  RecommendedMovieModel({
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.category,
    required this.year
  });
}

class EpisodeModel {
  final int id;
  final String title;
  final String duration;
  final String description;
  final String imageUrl;
  EpisodeModel({required this.id, required this.title, required this.duration, required this.description, required this.imageUrl});
}
// In your controller or a shared models file
