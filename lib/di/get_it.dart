import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:seriestv_jobcity/blocs/actor_tvshows/actortvshows_bloc.dart';
import 'package:seriestv_jobcity/blocs/authentication/authentication_cubit.dart';
import 'package:seriestv_jobcity/blocs/authentication/fingerprint_cubit.dart';
import 'package:seriestv_jobcity/blocs/favorite/favorite_bloc.dart';
import 'package:seriestv_jobcity/blocs/loading/loading_cubit.dart';
import 'package:seriestv_jobcity/blocs/search_tvactor/searchtvactor_bloc.dart';
import 'package:seriestv_jobcity/blocs/search_tvshow/searchtvshow_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_detail/tvshowdetail_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_episode/tvshowepisode_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_grid/tvshows_grid_bloc.dart';
import 'package:seriestv_jobcity/data/api/api_base.dart';
import 'package:seriestv_jobcity/data/data_sources/authentication_local_data_source.dart';
import 'package:seriestv_jobcity/data/data_sources/tvmaze_local_data_source.dart';
import 'package:seriestv_jobcity/data/data_sources/tvmaze_remote_datasource.dart';
import 'package:seriestv_jobcity/data/repository/authentication_repository.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/change_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/check_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/delete_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/is_enable_finger.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/is_save_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/save_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/toggle_finger.dart';
import 'package:seriestv_jobcity/data/usecases/check_if_tvshow_favorite.dart';
import 'package:seriestv_jobcity/data/usecases/delete_favorite_tvshow.dart';
import 'package:seriestv_jobcity/data/usecases/get_actor_shows.dart';
import 'package:seriestv_jobcity/data/usecases/get_favorites_tvshow.dart';
import 'package:seriestv_jobcity/data/usecases/get_tvshow_detail.dart';
import 'package:seriestv_jobcity/data/usecases/get_tvshow_season.dart';
import 'package:seriestv_jobcity/data/usecases/get_tvshows.dart';
import 'package:seriestv_jobcity/data/usecases/save_tvshow.dart';
import 'package:seriestv_jobcity/data/usecases/search_tvactor.dart';
import 'package:seriestv_jobcity/data/usecases/search_tvshow.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiBase>(() => ApiBase(getItInstance()));

  // Data Sources
  getItInstance.registerLazySingleton<TVMazeRemoteDataSource>(
      () => TVMazeRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  // Repositories
  getItInstance.registerLazySingleton<TvMazeRepository>(
      () => TvMazeRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance()));

  // Use Cases
  getItInstance
      .registerLazySingleton<GetTvShows>(() => GetTvShows(getItInstance()));

  getItInstance.registerLazySingleton<GetTvShowDetail>(
      () => GetTvShowDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetTvShowSeasons>(
      () => GetTvShowSeasons(getItInstance()));

  getItInstance.registerLazySingleton<GetActorShows>(
      () => GetActorShows(getItInstance()));

  getItInstance
      .registerLazySingleton<SearchTvShow>(() => SearchTvShow(getItInstance()));

  getItInstance.registerLazySingleton<SearchTvActor>(
      () => SearchTvActor(getItInstance()));

  getItInstance
      .registerLazySingleton<SaveTvShow>(() => SaveTvShow(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteTvShows>(
    () => GetFavoriteTvShows(getItInstance()),
  );

  getItInstance.registerLazySingleton<DeleteFavoriteTvShow>(
    () => DeleteFavoriteTvShow(getItInstance()),
  );

  getItInstance.registerLazySingleton<CheckIfFavoriteTvShow>(
    () => CheckIfFavoriteTvShow(getItInstance()),
  );

  getItInstance.registerLazySingleton<SavePIN>(() => SavePIN(getItInstance()));

  getItInstance
      .registerLazySingleton<DeletePIN>(() => DeletePIN(getItInstance()));
  getItInstance
      .registerLazySingleton<CheckPIN>(() => CheckPIN(getItInstance()));
  getItInstance
      .registerLazySingleton<IsSavePIN>(() => IsSavePIN(getItInstance()));
  getItInstance
      .registerLazySingleton<ChangePIN>(() => ChangePIN(getItInstance()));

  getItInstance
      .registerLazySingleton<ToggleFinger>(() => ToggleFinger(getItInstance()));
  getItInstance.registerLazySingleton<IsEnabledFinger>(
      () => IsEnabledFinger(getItInstance()));

  // Blocs / Cubits
  getItInstance.registerFactory(() => TvShowGridBloc(
        getTvShows: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => TvShowDetailBloc(
        getTvShowDetail: getItInstance(),
        tvshowepisodeBloc: getItInstance(),
        favoriteBloc: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => FavoriteBloc(
        checkIfFavoriteTvShow: getItInstance(),
        deleteFavoriteTvShow: getItInstance(),
        getFavoriteTvShows: getItInstance(),
        saveTvShow: getItInstance(),
      ));

  getItInstance.registerFactory(() => TvshowepisodeBloc(
        getTvShowSeasons: getItInstance(),
      ));

  getItInstance.registerFactory(() => ActortvshowsBloc(
        getActorShows: getItInstance(),
      ));

  getItInstance
      .registerFactory(() => SearchTvShowBloc(searchTvShow: getItInstance()));

  getItInstance
      .registerFactory(() => SearchTvActorBloc(searchTvActor: getItInstance()));

  getItInstance.registerSingleton<AuthenticationCubit>(AuthenticationCubit(
    checkPIN: getItInstance(),
    deletePIN: getItInstance(),
    isSavePIN: getItInstance(),
    savePIN: getItInstance(),
    changePIN: getItInstance(),
  ));

  getItInstance.registerSingleton<FingerprintCubit>(FingerprintCubit(
    isEnabledFinger: getItInstance(),
    toogleFinger: getItInstance(),
  ));

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
}
