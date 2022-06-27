import 'dart:convert';

class Movie {
    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    String? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    // creado para darle id diferente al mismo elemento dependiendo si estan junto en la misma panatalla principal y pueda funcionar el Hero()
    String? heroId;

    // donde tenga la instancia de Movie se tendra acceso a este getter fullPostering
    get fullPostering { // esto reconstruye el url de la image para que devuelva la URL completa de la misma
      return posterPath != null ?
        'https://image.tmdb.org/t/p/w500$posterPath' 
        :
        'https://i.stack.imgur.com/GNhxO.png';
    }

    // para ve las peliculas en details
    get fullBackdropPath { // esto reconstruye el url de la image para que devuelva la URL completa de la misma
      return this.backdropPath != null ?
        'https://image.tmdb.org/t/p/w500$backdropPath' 
        :
        'https://i.stack.imgur.com/GNhxO.png';
    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult             : json["adult"],
        backdropPath      : json["backdrop_path"],
        genreIds          : List<int>.from(json["genre_ids"].map((x) => x)),
        id                : json["id"],
        originalLanguage  : json["original_language"],
        originalTitle     : json["original_title"],
        overview          : json["overview"],
        popularity        : json["popularity"].toDouble(),
        posterPath        : json["poster_path"],
        releaseDate       : json["release_date"],
        title             : json["title"],
        video             : json["video"],
        voteAverage       : json["vote_average"].toDouble(),
        voteCount         : json["vote_count"],
    );

    // Map<String, dynamic> toMap() => {
    //     "adult": adult,
    //     "backdrop_path": backdropPath,
    //     "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    //     "id": id,
    //     "original_language": originalLanguageValues.reverse[originalLanguage],
    //     "original_title": originalTitle,
    //     "overview": overview,
    //     "popularity": popularity,
    //     "poster_path": posterPath,
    //     "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    //     "title": title,
    //     "video": video,
    //     "vote_average": voteAverage,
    //     "vote_count": voteCount,
    // };
}

// enum OriginalLanguage { EN, JA }

// final originalLanguageValues = EnumValues({
//     "en": OriginalLanguage.EN,
//     "ja": OriginalLanguage.JA
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
