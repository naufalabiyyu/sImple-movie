import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:witt/witt.dart';

import '../constants/configuration.dart';
import '../dtos/in_movie_dto.dart';
import '../utils/http_response_utils.dart';
import 'http_service.dart';

class MovieService {
  MovieService(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _httpService = WProvider.of<HttpService>(context);
    });
  }

  late final HttpService _httpService;

  Future<List<InMovieDto>> getNowPlayingAsync({
    required num limit,
  }) async {
    final url = "${Configurations.baseUrl}/filmsNowShowing/?n=$limit";

    final response = await _httpService.get(url);
    if (!HttpResponseUtils.isSuccess(response, true)) {
      throw response;
    } else if (HttpResponseUtils.isNotFound(response)) {
      return [];
    }

    final List<dynamic> dataMap = jsonDecode(response.body)["films"];
    return dataMap.map((e) => InMovieDto.fromMap(e)).toList();
  }

  Future<List<InMovieDto>> getComingSoonAsync({
    required num limit,
  }) async {
    final url = "${Configurations.baseUrl}/filmsComingSoon/?n=$limit";

    final response = await _httpService.get(url);
    if (!HttpResponseUtils.isSuccess(response, true)) {
      throw response;
    } else if (HttpResponseUtils.isNotFound(response)) {
      return [];
    }

    final List<dynamic> dataMap = jsonDecode(response.body)["films"];
    return dataMap.map((e) => InMovieDto.fromMap(e)).toList();
  }

  Future<List<InMovieDto>> getMovieSearchAsync({
    required String query,
  }) async {
    final url = "${Configurations.baseUrl}/filmLiveSearch/?query=$query";

    final response = await _httpService.get(url);
    if (!HttpResponseUtils.isSuccess(response, true)) {
      throw response;
    } else if (HttpResponseUtils.isNotFound(response)) {
      return [];
    }

    final List<dynamic> dataMap = jsonDecode(response.body)["films"];
    return dataMap.map((e) => InMovieDto.fromMap(e)).toList();
  }
}
