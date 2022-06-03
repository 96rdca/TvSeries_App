import 'package:seriestv_jobcity/data/api/api_base.dart';
import 'package:seriestv_jobcity/data/models/tv_actor_model.dart';
import 'package:seriestv_jobcity/data/models/tvshow_episode_model.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/models/tvshow_season_model.dart';

abstract class TVMazeRemoteDataSource {
  Future<List<TvShow>> getTvShows(int page);
  Future<TvShow> getTvShowDetail(int showId);
  Future<List<TvShowSeason>> getTvShowSeasons(int showId);
  Future<List<TvShow>> getActorShows(int actorId);
  // Searches
  Future<List<TvShow>> getSearchTvShow(String searchParams);
  Future<List<TvActor>> getSearchTvActor(String searchParams);
}

class TVMazeRemoteDataSourceImpl extends TVMazeRemoteDataSource {
  final ApiBase _client;

  TVMazeRemoteDataSourceImpl(this._client);

  @override
  Future<List<TvShow>> getTvShows(int page) async {
    final response = await _client.get('/shows?page=$page');
    final tvShows = response.map<TvShow>((x) => TvShow.fromJson(x)).toList();
    return tvShows;
  }

  @override
  Future<List<TvShow>> getSearchTvShow(String searchParams) async {
    final response = await _client.get('/search/shows?q=$searchParams');
    final tvShows =
        response.map<TvShow>((x) => TvShow.fromJson(x['show'])).toList();
    return tvShows;
  }

  @override
  Future<List<TvActor>> getSearchTvActor(String searchParams) async {
    final response = await _client.get('/search/people?q=$searchParams');
    final tvActors =
        response.map<TvActor>((x) => TvActor.fromJson(x['person'])).toList();
    return tvActors;
  }

  @override
  Future<TvShow> getTvShowDetail(int showId) async {
    final response = await _client.get('/shows/$showId');
    final tvShow = TvShow.fromJson(response);
    return tvShow;
  }

  @override
  Future<List<TvShowSeason>> getTvShowSeasons(int showId) async {
    final response = await _client.get('/shows/$showId/episodes?specials=1');
    // final List<TvShowEpisode> episodes =
    //     response.map<TvShowEpisode>((x) => TvShowEpisode.fromJson(x)).toList();
    final tvSeason = response
        .fold({}, (previousValue, element) {
          Map val = previousValue as Map;
          int? season = element['season'];
          if (!val.containsKey(season)) {
            val[season] = [];
          }
          val[season]?.add(element);
          return val;
        })
        .entries
        .map<TvShowSeason>((e) => TvShowSeason(
            season: e.key,
            episode: e.value
                .map<TvShowEpisode>((x) => TvShowEpisode.fromJson(x))
                .toList()))
        .toList();
    return tvSeason;
  }

  @override
  Future<List<TvShow>> getActorShows(int actorId) async {
    final response =
        await _client.get('/people/$actorId/castcredits?embed=show');
    final tvShow = response
        .map<TvShow>((e) => TvShow.fromJson(e['_embedded']['show']))
        .toList();
    return tvShow;
  }
}
