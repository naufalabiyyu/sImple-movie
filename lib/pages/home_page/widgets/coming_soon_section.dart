import 'package:flutter/material.dart';
import 'package:watt/watt.dart';
import 'package:witt/witt.dart';

import '../home_page_provider.dart';

class ComingSoonSection extends StatelessWidget {
  const ComingSoonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homePP = WProvider.of<HomePageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Coming Soon',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        WListener(
          notifiers: [homePP.comingSoonMovies],
          builder: (context) {
            final comingSoonMovies = homePP.comingSoonMovies.value;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Breakpoints.value(context, sm: 2, md: 4, lg: 5),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: comingSoonMovies.length,
              itemBuilder: (context, index) {
                final imageLandscape = comingSoonMovies[index].images?.still !=
                            null &&
                        comingSoonMovies[index].images?.still["1"] != null &&
                        comingSoonMovies[index].images?.still["1"]["medium"] !=
                            null
                    ? comingSoonMovies[index].images?.still["1"]["medium"]
                        ["film_image"] as String
                    : 'https://via.placeholder.com/180x100';

                return GestureDetector(
                  onTap: () => homePP.showMovieDetail(
                      context,
                      comingSoonMovies[index],
                      imageLandscape,
                      comingSoonMovies[index].filmTrailer),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageLandscape),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          comingSoonMovies[index].filmName ?? "No Title",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
