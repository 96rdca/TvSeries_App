import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_season_model.dart';
import 'package:seriestv_jobcity/data/usecases/get_tvshow_season.dart';

part 'tvshowepisode_event.dart';
part 'tvshowepisode_state.dart';

class TvshowepisodeBloc extends Bloc<TvshowepisodeEvent, TvshowepisodeState> {
  final GetTvShowSeasons getTvShowSeasons;
  TvshowepisodeBloc({required this.getTvShowSeasons})
      : super(TvshowepisodeInitial()) {
    on<TvShowEpisodeLoadEvent>((event, emit) async {
      final tvShowSeasonEither =
          await getTvShowSeasons(TvShowParams(event.showId));

      tvShowSeasonEither.fold(
        (error) => emit(TvshowepisodeError()),
        (tvShowSeasons) => emit(TvshowepisodeLoaded(tvShowSeasons)),
      );
    });
  }
}
