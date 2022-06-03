import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_season_model.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class GetTvShowSeasons extends UseCase<List<TvShowSeason>, TvShowParams> {
  final TvMazeRepository tvMazeRepository;

  GetTvShowSeasons(this.tvMazeRepository);

  @override
  Future<Either<AppError, List<TvShowSeason>>> call(TvShowParams params) async {
    return await tvMazeRepository.getTvShowSeasons(params.id);
  }
}
