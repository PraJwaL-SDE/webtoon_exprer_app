import 'package:shared_preferences/shared_preferences.dart';

class FavSharedPref {
  late SharedPreferences prefs;

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Add an index to the favorites list
  Future<void> addFav(int idx) async {
    final List<String> favList = prefs.getStringList('fav_items') ?? []; // Get existing list or an empty list
    if (!favList.contains(idx.toString())) {
      favList.add(idx.toString()); // Add the new index if it is not already in the list
      await prefs.setStringList('fav_items', favList); // Save updated list
    }
  }

  // Remove an index from the favorites list
  Future<void> removeFromFav(int idx) async {
    final List<String> favList = prefs.getStringList('fav_items') ?? []; // Get existing list or an empty list
    favList.remove(idx.toString()); // Remove the index
    await prefs.setStringList('fav_items', favList); // Save updated list
  }

  // Get the list of favorite indices
  List<int> getFavs() {
    final List<String> favList = prefs.getStringList('fav_items') ?? [];
    return favList.map((e) => int.parse(e)).toList(); // Convert the list of strings to a list of integers
  }

  // Check if an item is favorited
  bool isFav(int idx) {
    final List<String> favList = prefs.getStringList('fav_items') ?? [];
    return favList.contains(idx.toString());
  }
}
