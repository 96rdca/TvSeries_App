import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/no_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class GetFavoriteTvShows extends UseCase<List<TvShow>, NoParams> {
  final TvMazeRepository tvMazeRepository;

  GetFavoriteTvShows(this.tvMazeRepository);

  @override
  Future<Either<AppError, List<TvShow>>> call(NoParams params) async {
    return await tvMazeRepository.getFavoriteTvShows();
  }
}
