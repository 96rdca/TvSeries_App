import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class GetTvShows extends UseCase<List<TvShow>, TvShowParams> {
  final TvMazeRepository tvMazeRepository;

  GetTvShows(this.tvMazeRepository);

  @override
  Future<Either<AppError, List<TvShow>>> call(TvShowParams params) async {
    return await tvMazeRepository.getTvShows(params.id);
  }
}
