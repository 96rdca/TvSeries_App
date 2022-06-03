import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class DeleteFavoriteTvShow extends UseCase<void, TvShowParams> {
  final TvMazeRepository tvMazeRepository;

  DeleteFavoriteTvShow(this.tvMazeRepository);

  @override
  Future<Either<AppError, void>> call(TvShowParams params) async {
    return await tvMazeRepository.deleteFavoriteTvShow(params.id);
  }
}
