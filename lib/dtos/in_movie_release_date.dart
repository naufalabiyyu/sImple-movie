import 'dart:convert';

class InMovieReleaseDate {
  final String? releaseDate;
  InMovieReleaseDate({
    this.releaseDate,
  });

  InMovieReleaseDate copyWith({
    String? releaseDate,
  }) {
    return InMovieReleaseDate(
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'release_date': releaseDate,
    };
  }

  factory InMovieReleaseDate.fromMap(Map<String, dynamic> map) {
    return InMovieReleaseDate(
      releaseDate:
          map['release_date'] != null ? map['release_date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InMovieReleaseDate.fromJson(String source) =>
      InMovieReleaseDate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'InMovieReleaseDate(releaseDate: $releaseDate)';

  @override
  bool operator ==(covariant InMovieReleaseDate other) {
    if (identical(this, other)) return true;

    return other.releaseDate == releaseDate;
  }

  @override
  int get hashCode => releaseDate.hashCode;
}
