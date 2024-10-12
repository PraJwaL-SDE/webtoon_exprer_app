import 'package:flutter/material.dart';
import '../models/anime_model.dart';


class AnimeProvider extends ChangeNotifier {
  List<AnimeModel> _animeList = [];

  List<AnimeModel> get animeList => _animeList; // Getter for the anime list

  // Method to add an anime to the list
  void addAnime(AnimeModel anime) {
    _animeList.add(anime);
    notifyListeners(); // Notify listeners when the list is updated
  }

  // Method to toggle the favorite status of an anime
  void toggleFavourite(AnimeModel anime) {
    anime.isFavourite = !anime.isFavourite;
    notifyListeners(); // Notify listeners when the favorite status is updated
  }

  // Method to update the rating of an anime
  void updateRating(AnimeModel anime, Rating newRating) {
    anime.rating = newRating;
    notifyListeners(); // Notify listeners when the rating is updated
  }

  // Method to set the anime list (useful when fetching data)
  void setAnimeList(List<AnimeModel> animeList) {
    _animeList = animeList;
    notifyListeners(); // Notify listeners when the anime list is updated
  }

  // Method to get an anime by index
  AnimeModel getAnimeByIndex(int index) {
    return _animeList[index];
  }

  // Method to remove an anime by index
  void removeAnimeByIndex(int index) {
    _animeList.removeAt(index);
    notifyListeners(); // Notify listeners when the list changes
  }
}
