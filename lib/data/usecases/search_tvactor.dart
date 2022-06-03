import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/tv_actor_model.dart';
import 'package:seriestv_jobcity/data/models/params/tv_search_params.dart';
import 'package:seriestv_jobcity/data/repository/tvmaze_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class SearchTvActor extends UseCase<List<TvActor>, TvSearchParams> {
  final TvMazeRepository tvMazeRepository;

  SearchTvActor(this.tvMazeRepository);

  @override
  Future<Either<AppError, List<TvActor>>> call(TvSearchParams params) async {
    return await tvMazeRepository.getSearchTvActor(params.searchTerm);
  }
}
