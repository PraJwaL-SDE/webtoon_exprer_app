enum Rating { one, two, three, four, five }

extension RatingExtension on Rating {
  int get value {
    switch (this) {
      case Rating.one:
        return 1;
      case Rating.two:
        return 2;
      case Rating.three:
        return 3;
      case Rating.four:
        return 4;
      case Rating.five:
        return 5;
    }
  }
}

class AnimeModel {
  String _title;
  String _thumbnail;
  String _creator;
  String _genre;
  String _description;
  bool _isFavourite;
  Rating _rating; // Added rating enum

  // Constructor
  AnimeModel({
    required String title,
    required String thumbnail,
    required String creator,
    required String genre,
    required String description,
    bool isFavourite = false, // Default value for isFavourite
    Rating rating = Rating.three, // Default rating value
  })  : _title = title,
        _thumbnail = thumbnail,
        _creator = creator,
        _genre = genre,
        _description = description,
        _isFavourite = isFavourite,
        _rating = rating; // Assign rating

  // Getters
  String get title => _title;
  String get thumbnail => _thumbnail;
  String get creator => _creator;
  String get genre => _genre;
  String get description => _description;
  bool get isFavourite => _isFavourite;
  Rating get rating => _rating; // Getter for rating

  // Setters
  set title(String value) {
    _title = value;
  }

  set thumbnail(String value) {
    _thumbnail = value;
  }

  set creator(String value) {
    _creator = value;
  }

  set genre(String value) {
    _genre = value;
  }

  set description(String value) {
    _description = value;
  }

  set isFavourite(bool value) {
    _isFavourite = value;
  }

  set rating(Rating value) {
    _rating = value;
  }

  // toString method for easy printing of the object
  @override
  String toString() {
    return 'AnimeModel{title: $_title, thumbnail: $_thumbnail, creator: $_creator, genre: $_genre, description: $_description, isFavourite: $_isFavourite, rating: ${_rating.value}}';
  }

  // Convert AnimeModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'thumbnail': _thumbnail,
      'creator': _creator,
      'genre': _genre,
      'description': _description,
      'isFavourite': _isFavourite,
      'rating': _rating.value, // Store rating as an integer value
    };
  }

  // Create an AnimeModel object from a Map
  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      title: map['title'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      creator: map['creator'] ?? '',
      genre: map['genre'] ?? '',
      description: map['description'] ?? '',
      isFavourite: map['isFavourite'] ?? false,
      rating: Rating.values[map['rating'] - 1], // Convert integer back to enum
    );
  }
}
