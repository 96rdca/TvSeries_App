import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class SaveTvShow extends UseCase<void, TvShow> {
  final TvMazeRepository tvMazeRepository;

  SaveTvShow(this.tvMazeRepository);

  @override
  Future<Either<AppError, void>> call(TvShow params) async {
    return await tvMazeRepository.saveTvShow(params);
  }
}
