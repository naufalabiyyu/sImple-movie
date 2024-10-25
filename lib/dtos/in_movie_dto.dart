import 'dart:convert';

import 'in_movie_image_dto.dart';
import 'in_movie_release_date.dart';

class InMovieDto {
  final num? filmId;
  final String? filmName;
  final List<InMovieReleaseDate>? releaseDates;
  final String? filmTrailer;
  final String? synopsisLong;
  final InMovieImageDto? images;

  InMovieDto({
    this.filmId,
    this.filmName,
    this.releaseDates,
    this.filmTrailer,
    this.synopsisLong,
    this.images,
  });

  InMovieDto copyWith({
    num? filmId,
    String? filmName,
    List<InMovieReleaseDate>? releaseDates,
    String? filmTrailer,
    String? synopsisLong,
    InMovieImageDto? images,
  }) {
    return InMovieDto(
      filmId: filmId ?? this.filmId,
      filmName: filmName ?? this.filmName,
      releaseDates: releaseDates ?? this.releaseDates,
      filmTrailer: filmTrailer ?? this.filmTrailer,
      synopsisLong: synopsisLong ?? this.synopsisLong,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'film_id': filmId,
      'film_name': filmName,
      'release_dates': releaseDates?.map((x) => x.toMap()).toList(),
      'film_trailer': filmTrailer,
      'synopsis_long': synopsisLong,
      'images': images?.toMap(),
    };
  }

  factory InMovieDto.fromMap(Map<String, dynamic> map) {
    return InMovieDto(
      filmId: map['film_id'] != null ? map['film_id'] as num : null,
      filmName: map['film_name'] != null ? map['film_name'] as String : null,
      releaseDates: map['release_dates'] != null
          ? List<InMovieReleaseDate>.from(
              map['release_dates'].map<InMovieReleaseDate?>(
                (x) => InMovieReleaseDate.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      filmTrailer:
          map['film_trailer'] != null ? map['film_trailer'] as String : null,
      synopsisLong:
          map['synopsis_long'] != null ? map['synopsis_long'] as String : null,
      images: map['images'] != null
          ? InMovieImageDto.fromMap(map['images'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InMovieDto.fromJson(String source) =>
      InMovieDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
