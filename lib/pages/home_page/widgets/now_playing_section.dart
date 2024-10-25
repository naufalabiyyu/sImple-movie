import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watt/watt.dart';
import 'package:witt/witt.dart';

import '../home_page_provider.dart';

class NowPlayingSection extends StatelessWidget {
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);
    final textTheme = Theme.of(context).textTheme;

    final homePP = WProvider.of<HomePageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Now Playing",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        WListener(
          notifiers: [homePP.nowPlayingMovies],
          builder: (context) {
            final nowPlayingMovies = homePP.nowPlayingMovies.value;

            return CarouselSlider(
              options: CarouselOptions(
                height: 156,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: nowPlayingMovies.map(
                (movie) {
                  final imagePoster = movie.images?.poster != null &&
                          movie.images?.poster["1"] != null &&
                          movie.images?.poster["1"]["medium"] != null
                      ? movie.images?.poster["1"]["medium"]["film_image"]
                          as String
                      : 'https://via.placeholder.com/150';

                  final imageLandscape = movie.images?.still != null &&
                          movie.images?.still["1"] != null &&
                          movie.images?.still["1"]["medium"] != null
                      ? movie.images?.still["1"]["medium"]["film_image"]
                          as String
                      : 'https://via.placeholder.com/150';

                  return GestureDetector(
                    onTap: () => homePP.showMovieDetail(
                      context,
                      movie,
                      imageLandscape,
                      movie.filmTrailer,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              imagePoster,
                              height: 100.0,
                              width: 80.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  movie.filmName ?? "No Title",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.synopsisLong ??
                                      "No description available.",
                                  style: textTheme.bodySmall!
                                      .copyWith(color: palette.gray),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
