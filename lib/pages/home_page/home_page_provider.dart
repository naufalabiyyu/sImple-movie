import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:watt/watt.dart';
import 'package:witt/witt.dart';

import '../../dtos/in_movie_dto.dart';
import '../../http_handler.dart';
import '../../services/movie_service.dart';
import 'widgets/movie_detail_sheet.dart';

class HomePageProvider {
  HomePageProvider(this.context) {
    Future.delayed(Duration.zero, () {
      _movieService = WProvider.of<MovieService>(context);
      searchQuery.addListener(onSearchMoviesLoadAsync);

      initializeAsync();
    });
  }

  final BuildContext context;

  late final MovieService _movieService;

  final isSearchView = ValueNotifier(false);
  final loaderState = ValueNotifier(LoaderState.loading);
  final nowPlayingMovies = ValueNotifier(<InMovieDto>[]);
  final comingSoonMovies = ValueNotifier(<InMovieDto>[]);
  final searchQuery = ValueNotifier("");
  final searchMovieResult = ValueNotifier(<InMovieDto>[]);
  final videoControllerNotifier = ValueNotifier<VideoPlayerController?>(null);

  final textController = TextEditingController();

  void dispose() {
    nowPlayingMovies.dispose();
    comingSoonMovies.dispose();
    videoControllerNotifier.value?.dispose();
    videoControllerNotifier.dispose();
    searchQuery.removeListener(onSearchMoviesLoadAsync);
  }

  Future<void> initializeAsync() async {
    nowPlayingMovies.value = [];

    final httpHandler = HttpHandler(loaderState: loaderState);
    try {
      httpHandler.start();

      await onNowPlayingMoviesLoadAsync();
      await onComingSoonMoviesLoadAsync();

      httpHandler.stop();
    } catch (e, stackTrace) {
      httpHandler.handleException(e, stackTrace);
    }
  }

  Future<void> onNowPlayingMoviesLoadAsync() async {
    final data = await _movieService.getNowPlayingAsync(limit: 5);

    nowPlayingMovies.value = data;
  }

  Future<void> onComingSoonMoviesLoadAsync() async {
    final data = await _movieService.getComingSoonAsync(limit: 10);

    comingSoonMovies.value = data;
  }

  Future<void> onSearchMoviesLoadAsync() async {
    searchMovieResult.value = [];
    final searchQuery = this.searchQuery.value.trim();
    final data = await _movieService.getMovieSearchAsync(query: searchQuery);

    searchMovieResult.value = data;
  }

  void showMovieDetail(
    BuildContext context,
    InMovieDto movie,
    String imageLandscape,
    String? filmTrailer,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MovieDetailSheet(
          filmName: movie.filmName,
          synopsisLong: movie.synopsisLong,
          imageLandscape: imageLandscape,
          filmTrailer: filmTrailer,
        );
      },
    );
  }
}
