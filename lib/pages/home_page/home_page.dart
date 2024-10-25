import 'package:flutter/material.dart';
import 'package:witt/witt.dart';

import '../../app_router.dart';
import 'home_page_provider.dart';
import 'widgets/coming_soon_section.dart';
import 'widgets/now_playing_section.dart';
import 'widgets/search_movie_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homePP = WProvider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Netplix'),
        actions: [
          WListener(
            notifiers: [homePP.isSearchView],
            builder: (context) {
              return homePP.isSearchView.value == false
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        homePP.isSearchView.value = true;
                      },
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Netplix Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                homePP.isSearchView.value = false;
                AppRouter.pop();
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: WListener(
          notifiers: [homePP.isSearchView],
          builder: (context) {
            final isSearch = homePP.isSearchView.value;
            return !isSearch
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NowPlayingSection(),
                      SizedBox(height: 16),
                      ComingSoonSection(),
                    ],
                  )
                : const SearchMovieView();
          },
        ),
      ),
    );
  }
}
