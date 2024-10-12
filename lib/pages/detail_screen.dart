import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/anime_model.dart';
import '../test_data/fav_shared_pref.dart';

class DetailScreen extends StatefulWidget {
  final AnimeModel anime;
  final int index; // Add the index to the constructor

  const DetailScreen({super.key, required this.anime, required this.index}); // Include the index in the constructor

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late AnimeModel _anime;
  final FavSharedPref favSharedPref = FavSharedPref();

  @override
  void initState() {
    super.initState();
    _anime = widget.anime;
    _loadFavStatus(); // Load the favorite status when the screen is initialized
  }

  // Load the favorite status from SharedPreferences
  Future<void> _loadFavStatus() async {
    await favSharedPref.init(); // Initialize SharedPreferences
    setState(() {
      _anime.isFavourite = favSharedPref.isFav(widget.index); // Check if this anime (by index) is in favorites
    });
  }

  // Toggle the favorite status
  void _toggleFavorite() {
    setState(() {
      _anime.isFavourite = !_anime.isFavourite; // Toggle favorite status
      if (_anime.isFavourite) {
        favSharedPref.addFav(widget.index); // Add the index to favorites
      } else {
        favSharedPref.removeFromFav(widget.index); // Remove the index from favorites
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
            children: [
              // Title
              Text(
                _anime.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10), // Space between title and image

              // Thumbnail
              Container(
                height: 300,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        _anime.thumbnail,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.fill, // Use BoxFit.cover for maintaining aspect ratio
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: _toggleFavorite, // Toggle favorite status when clicked
                        child: Material(
                          elevation: 4, // Set elevation for a shadow effect
                          shape: const CircleBorder(), // Make the icon circular
                          child: Container(
                            height: 40, // Increased height for better visibility
                            width: 40,  // Increased width for better visibility
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle, // Ensure the container is circular
                              color: Colors.white, // Background color for better contrast
                            ),
                            child: Center(
                              child: Icon(
                                _anime.isFavourite ? Icons.favorite : Icons.favorite_border, // Use Flutter's built-in icons
                                color: _anime.isFavourite ? Colors.red : Colors.black, // Change color based on state
                                size: 30, // Size of the icon
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20), // Space after image

              // Creator
              Row(
                children: [
                  const Text(
                    "Creator: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _anime.creator,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Space between creator and genre

              // Genre
              Row(
                children: [
                  const Text(
                    "Genre: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _anime.genre,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Space between genre and description

              // Description
              const Text(
                "Description:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5), // Space between description title and text
              Text(
                _anime.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
