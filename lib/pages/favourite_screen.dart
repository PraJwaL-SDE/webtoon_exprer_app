import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../test_data/anime_data_list.dart';
import '../test_data/fav_shared_pref.dart'; // Assuming you have a separate file for FavSharedPref

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavSharedPref favSharedPref = FavSharedPref(); // Instance of FavSharedPref
  List<int> favIndexes = []; // To store favorite anime indices

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Load favorite indices when screen is initialized
  }

  // Load favorite indices from SharedPreferences
  Future<void> _loadFavorites() async {
    await favSharedPref.init(); // Initialize shared preferences
    setState(() {
      favIndexes = favSharedPref.getFavs(); // Retrieve favorite indices
    });
  }

  // Function to build stars based on the rating
  Widget buildRatingStars(AnimeModel anime) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              anime.rating = Rating.values[index]; // Update the rating
            });
          },
          child: Icon(
            index < anime.rating.value ? Icons.star : Icons.star_border,
            color: Colors.yellow,
            size: 30, // Increased size for better visibility
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Animes"),
        centerTitle: true,
      ),
      body: favIndexes.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : ListView.builder(
        itemCount: favIndexes.length,
        itemBuilder: (context, index) {
          // Get anime by favorite index
          final animeData = AnimeDataList.webtoons[favIndexes[index]];
          AnimeModel anime = AnimeModel(
            title: animeData["title"]!,
            thumbnail: animeData["thumbnail"]!,
            creator: animeData["creator"]!,
            genre: animeData["genre"]!,
            description: animeData["description"]!,
          );

          return Card(
            elevation: 5, // Add shadow to make it look more prominent
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Rounded corners for thumbnail
                child: Image.network(
                  anime.thumbnail,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                anime.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(anime.genre, style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 10),
                  buildRatingStars(anime), // Rating stars
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
