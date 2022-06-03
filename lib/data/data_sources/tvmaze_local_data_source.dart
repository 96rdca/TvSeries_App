import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';

abstract class TvShowLocalDataSource {
  Future<void> saveTvShow(TvShow tvShow);
  Future<List<TvShow>> getTvShows();
  Future<void> deleteTvShow(int tvShowId);
  Future<bool> checkIfTvShowFavorite(int tvShowId);
}

class TvShowLocalDataSourceImpl extends TvShowLocalDataSource {
  @override
  Future<bool> checkIfTvShowFavorite(int tvShowId) async {
    final tvShowBox = await Hive.openBox('tvShowBox');
    return tvShowBox.containsKey(tvShowId);
  }

  @override
  Future<void> deleteTvShow(int tvShowId) async {
    final tvShowBox = await Hive.openBox('tvShowBox');
    await tvShowBox.delete(tvShowId);
  }

  @override
  Future<List<TvShow>> getTvShows() async {
    final tvShowBox = await Hive.openBox('tvShowBox');
    final tvShowIds = tvShowBox.keys;

    // List<TvShow>  = [];
    final movies = tvShowIds.map<TvShow>((e) {
      final tvShowJson = tvShowBox.get(e);
      final tvShow = TvShow.fromJson(json.decode(tvShowJson.toString()));
      return tvShow;
    }).toList();
    // for (var i = 0; i < tvShowIds.length; i++) {
    //   var tvShowJson = tvShowBox.get();
    //   final tvShow = TvShow.fromJson(json.decode(tvShowJson.toString()));
    //   movies.add(tvShow);
    // }
    // tvShowIds.forEach((movieId) {});

    return movies;
  }

  @override
  Future<void> saveTvShow(TvShow tvShow) async {
    final tvShowBox = await Hive.openBox('tvShowBox');
    final data = json.encode(tvShow.toJson());
    await tvShowBox.put(tvShow.id, data);
  }
}
