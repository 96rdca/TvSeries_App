import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/common/enums/apperror_type.dart';
import 'package:seriestv_jobcity/common/logger.dart';
import 'package:seriestv_jobcity/data/data_sources/tvmaze_local_data_source.dart';
import 'package:seriestv_jobcity/data/data_sources/tvmaze_remote_datasource.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/tv_actor_model.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/models/tvshow_season_model.dart';

abstract class TvMazeRepository {
  Future<Either<AppError, List<TvShow>>> getTvShows(int page);
  Future<Either<AppError, TvShow>> getTvShowDetail(int showId);
  Future<Either<AppError, List<TvShowSeason>>> getTvShowSeasons(int showId);
  Future<Either<AppError, List<TvShow>>> getActorShows(int actorId);

  Future<Either<AppError, List<TvShow>>> getSearchTvShow(String searchParams);
  Future<Either<AppError, List<TvActor>>> getSearchTvActor(String searchParams);

  // Local

  Future<Either<AppError, void>> saveTvShow(TvShow tvShow);
  Future<Either<AppError, List<TvShow>>> getFavoriteTvShows();
  Future<Either<AppError, void>> deleteFavoriteTvShow(int tvShowId);
  Future<Either<AppError, bool>> checkIfTvShowFavorite(int tvShowId);
}

class TvMazeRepositoryImpl extends TvMazeRepository {
  final log = getLogger('TvMazeRepositoryImpl');

  final TVMazeRemoteDataSource tvMazeRemoteDataSource;
  final TvShowLocalDataSource tvShowLocalDataSource;

  TvMazeRepositoryImpl(this.tvMazeRemoteDataSource, this.tvShowLocalDataSource);

  @override
  Future<Either<AppError, List<TvShow>>> getTvShows(int page) async {
    try {
      final tvShows = await tvMazeRemoteDataSource.getTvShows(page);
      return Right(tvShows);
    } on SocketException catch (e) {
      log.e(e.message);
      return const Left(AppError(AppErrorType.network));
    } on Exception catch (e) {
      log.e(e);
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, TvShow>> getTvShowDetail(int showId) async {
    try {
      final tvShow = await tvMazeRemoteDataSource.getTvShowDetail(showId);
      return Right(tvShow);
    } on SocketException catch (e) {
      log.e(e.message);
      return const Left(AppError(AppErrorType.network));
    } on Exception catch (e) {
      log.e(e);
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<TvShow>>> getSearchTvShow(
      String searchParams) async {
    try {
      final tvShows =
          await tvMazeRemoteDataSource.getSearchTvShow(searchParams);
      return Right(tvShows);
    } on SocketException catch (e) {
      log.e(e.message);
      return const Left(AppError(AppErrorType.network));
    } on Exception catch (e) {
      log.e(e);
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<TvActor>>> getSearchTvActor(
      String searchParams) async {
    try {
      final tvActors =
          await tvMazeRemoteDataSource.getSearchTvActor(searchParams);
      return Right(tvActors);
    } on SocketException catch (e) {
      log.e(e.message);
      return const Left(AppError(AppErrorType.network));
    } on Exception catch (e) {
      log.e(e);
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<TvShowSeason>>> getTvShowSeasons(
      int showId) async {
    try {
      final tvShowSeasons =
          await tvMazeRemoteDataSource.getTvShowSeasons(showId);
      return Right(tvShowSeasons);
    } on SocketException catch (e) {
      log.e(e.message);
      return const Left(AppError(AppErrorType.network));
    } on Exception catch (e) {
      log.e(e);
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<TvShow>>> getActorShows(int actorId) async {
    try {
      final tvShows = await tvMazeRemoteDataSource.getActorShows(actorId);
      return Right(tvShows);
    } on SocketException catch (e) {
      log.e(e.message);
      return const Left(AppError(AppErrorType.network));
    } on Exception catch (e) {
      log.e(e);
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfTvShowFavorite(int tvShowId) async {
    try {
      final response =
          await tvShowLocalDataSource.checkIfTvShowFavorite(tvShowId);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteTvShow(int tvShowId) async {
    try {
      final response = await tvShowLocalDataSource.deleteTvShow(tvShowId);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<TvShow>>> getFavoriteTvShows() async {
    try {
      final response = await tvShowLocalDataSource.getTvShows();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveTvShow(TvShow tvShow) async {
    try {
      final response = await tvShowLocalDataSource.saveTvShow(tvShow);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
