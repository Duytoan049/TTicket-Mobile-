class Movie {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final String? posterPath;
  final String? backdropPath;
  final List<String> genres;
  final List<String> spokenLanguages;
  final List<String> productionCompanies;
  final String? status;
  final String? tagline;
  final String? homepage;
  final int? runtime;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.posterPath,
    this.backdropPath,
    required this.genres,
    required this.spokenLanguages,
    required this.productionCompanies,
    this.status,
    this.tagline,
    this.homepage,
    this.runtime,
  });

  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      originalTitle: json['original_title'] ?? 'Unknown',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genres: (json['genres'] as List?)?.map((genre) => genre['name'] as String).toList() ?? [],
      spokenLanguages: (json['spoken_languages'] as List?)?.map((lang) => lang['english_name'] as String).toList() ?? [],
      productionCompanies: (json['production_companies'] as List?)?.map((company) => company['name'] as String).toList() ?? [],
      status: json['status'],
      tagline: json['tagline'],
      homepage: json['homepage'],
      runtime: json['runtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'genres': genres
          .map((genre) => {
                'name': genre
              })
          .toList(),
      'spoken_languages': spokenLanguages
          .map((lang) => {
                'english_name': lang
              })
          .toList(),
      'production_companies': productionCompanies
          .map((company) => {
                'name': company
              })
          .toList(),
      'status': status,
      'tagline': tagline,
      'homepage': homepage,
      'runtime': runtime,
    };
  }
}

class MovieDetail {
  final bool adult;
  final String backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromMap(Map<String, dynamic> json) {
    return MovieDetail(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genres: (json['genres'] as List).map((e) => Genre.fromMap(e)).toList(),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: (json['production_companies'] as List).map((e) => ProductionCompany.fromMap(e)).toList(),
      productionCountries: (json['production_countries'] as List).map((e) => ProductionCountry.fromMap(e)).toList(),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List).map((e) => SpokenLanguage.fromMap(e)).toList(),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromMap(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String originCountry;
  final String? logoPath;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.originCountry,
    this.logoPath,
  });

  factory ProductionCompany.fromMap(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      name: json['name'],
      originCountry: json['origin_country'],
      logoPath: json['logo_path'],
    );
  }
}

class ProductionCountry {
  final String iso;
  final String name;

  ProductionCountry({required this.iso, required this.name});

  factory ProductionCountry.fromMap(Map<String, dynamic> json) {
    return ProductionCountry(
      iso: json['iso_3166_1'],
      name: json['name'],
    );
  }
}

class SpokenLanguage {
  final String iso;
  final String name;

  SpokenLanguage({required this.iso, required this.name});

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) {
    return SpokenLanguage(
      iso: json['iso_639_1'],
      name: json['name'],
    );
  }
}
