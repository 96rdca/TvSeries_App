import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class CheckIfFavoriteTvShow extends UseCase<bool, TvShowParams> {
  final TvMazeRepository tvMazeRepository;

  CheckIfFavoriteTvShow(this.tvMazeRepository);

  @override
  Future<Either<AppError, bool>> call(TvShowParams params) async {
    return await tvMazeRepository.checkIfTvShowFavorite(params.id);
  }
}
