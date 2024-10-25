import 'dart:convert';

class InMovieImageDto {
  final dynamic poster;
  final dynamic still;

  InMovieImageDto({
    required this.poster,
    required this.still,
  });

  InMovieImageDto copyWith({
    dynamic poster,
    dynamic still,
  }) {
    return InMovieImageDto(
      poster: poster ?? this.poster,
      still: still ?? this.still,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'poster': poster,
      'still': still,
    };
  }

  factory InMovieImageDto.fromMap(Map<String, dynamic> map) {
    return InMovieImageDto(
      poster: map['poster'] as dynamic,
      still: map['still'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory InMovieImageDto.fromJson(String source) =>
      InMovieImageDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
