import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/anime_model.dart';
import 'package:webtoon_explorer_app/pages/detail_screen.dart';
import 'package:webtoon_explorer_app/pages/favourite_screen.dart';
import 'package:webtoon_explorer_app/test_data/anime_data_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft, // Aligns the text to the left
              child: Text(
                "Top Trending Anime",
                style: const TextStyle(
                  fontSize: 16, // Slightly smaller font size for long titles
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Darker color for text contrast
                ),
              ),
            ),
          ),
          SizedBox(
            height: 250, // Adjusted height for the card section
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: AnimeDataList.webtoons.length,
                itemBuilder: (context,index){
                  AnimeModel anime = AnimeModel(
                      title: AnimeDataList.webtoons[index]["title"]!,
                      thumbnail: AnimeDataList.webtoons[index]["thumbnail"]!,
                      creator: AnimeDataList.webtoons[index]["creator"]!,
                      genre: AnimeDataList.webtoons[index]["genre"]!,
                      description: AnimeDataList.webtoons[index]["description"]!
                  );

                  return horizontalScrollItemsView(anime,index);

                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft, // Aligns the text to the left
              child: Text(
                "Other Categories",
                style: const TextStyle(
                  fontSize: 16, // Slightly smaller font size for long titles
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Darker color for text contrast
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavouriteScreen()),
                ),
                child: Container(
                  height: 75,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10), // Rounded corners for smooth appearance
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Shadow color
                        blurRadius: 10, // Blur effect
                        offset: Offset(0, 5), // Shadow position
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color for contrast
                        letterSpacing: 1.5, // For better typography
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget horizontalScrollItemsView(AnimeModel anime,int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(anime: anime,index : index)));
        print("Card tapped!"); // Add functionality when the card is tapped
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2, // Slightly lower elevation
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Margin for space between cards
        child: Container(
          width: 180, // Adjusted width for a balanced look
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25), // Softer shadow color
                spreadRadius: 2,  // Reduced spreadRadius for smaller shadow area
                blurRadius: 5,    // Reduced blur for tighter shadow effect
                offset: const Offset(0, 3), // Reduced shadow offset
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  anime.thumbnail,
                  height: 180, // Adjusted height for image proportion
                  width: double.infinity,
                  fit: BoxFit.fill, // Ensures the image covers the container
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0), // Added padding inside the card
                child: Text(
                  anime.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14, // Slightly smaller font size for long titles
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Darker color for text contrast
                  ),
                  maxLines: 1, // Limits the title to one line
                  overflow: TextOverflow.ellipsis, // Adds "..." to truncated text
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
