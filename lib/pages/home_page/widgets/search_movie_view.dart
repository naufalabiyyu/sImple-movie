import 'package:flutter/material.dart';
import 'package:watt/watt.dart';
import 'package:witt/witt.dart';
import '../home_page_provider.dart';
import '/widgets/search_bar.dart' as widget;

class SearchMovieView extends StatelessWidget {
  const SearchMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    final homePP = WProvider.of<HomePageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.SearchBar(
            controller: homePP.textController,
            onSubmitted: (value) => homePP.searchQuery.value = value,
          ),
          const Flexible(
            fit: FlexFit.loose,
            child: MovieCard(),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homePP = WProvider.of<HomePageProvider>(context);
    return WListener(
      notifiers: [homePP.searchMovieResult],
      builder: (context) {
        final searchMovieResult = homePP.searchMovieResult.value;

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
          itemCount: searchMovieResult.length,
          itemBuilder: (context, index) {
            final imageLandscape =
                searchMovieResult[index].images?.still != null &&
                        searchMovieResult[index].images?.still["1"] != null &&
                        searchMovieResult[index].images?.still["1"]["medium"] !=
                            null
                    ? searchMovieResult[index].images?.still["1"]["medium"]
                        ["film_image"] as String
                    : 'https://via.placeholder.com/180x100';

            return GestureDetector(
              onTap: () => homePP.showMovieDetail(
                context,
                searchMovieResult[index],
                imageLandscape,
                searchMovieResult[index].filmTrailer,
              ),
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
                      searchMovieResult[index].filmName ?? "No Title",
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
    );
  }
}
