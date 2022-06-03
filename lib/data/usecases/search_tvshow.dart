import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/models/params/tv_search_params.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class SearchTvShow extends UseCase<List<TvShow>, TvSearchParams> {
  final TvMazeRepository tvMazeRepository;

  SearchTvShow(this.tvMazeRepository);

  @override
  Future<Either<AppError, List<TvShow>>> call(TvSearchParams params) async {
    return await tvMazeRepository.getSearchTvShow(params.searchTerm);
  }
}
