import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/favorite/favorite_bloc.dart';
import 'package:seriestv_jobcity/blocs/loading/loading_cubit.dart';
import 'package:seriestv_jobcity/blocs/tvshow_episode/tvshowepisode_bloc.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/usecases/get_tvshow_detail.dart';

part 'tvshowdetail_event.dart';
part 'tvshowdetail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail getTvShowDetail;
  final TvshowepisodeBloc tvshowepisodeBloc;
  final FavoriteBloc favoriteBloc;
  final LoadingCubit loadingCubit;

  TvShowDetailBloc({
    required this.getTvShowDetail,
    required this.tvshowepisodeBloc,
    required this.favoriteBloc,
    required this.loadingCubit,
  }) : super(TvShowDetailInitial()) {
    on<TvShowDetailLoadEvent>((event, emit) async {
      if (!event.isFromSaved) {
        emit(TvShowDetailLoaded(event.tvShow));
      } else {
        loadingCubit.show();

        final tvShowEither =
            await getTvShowDetail(TvShowParams(event.tvShow.id!));

        tvShowEither.fold(
          (error) => emit(TvShowDetailError()),
          (tvShow) => emit(TvShowDetailLoaded(tvShow)),
        );

        loadingCubit.hide();
      }
      favoriteBloc.add(CheckIfFavoriteTvShowEvent(event.tvShow.id!));
      tvshowepisodeBloc.add(TvShowEpisodeLoadEvent(showId: event.tvShow.id!));
    });
  }
}
