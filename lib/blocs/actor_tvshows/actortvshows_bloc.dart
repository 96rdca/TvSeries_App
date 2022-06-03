import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/usecases/get_actor_shows.dart';

part 'actortvshows_event.dart';
part 'actortvshows_state.dart';

class ActortvshowsBloc extends Bloc<ActortvshowsEvent, ActortvshowsState> {
  final GetActorShows getActorShows;
  ActortvshowsBloc({required this.getActorShows})
      : super(ActortvshowsInitial()) {
    on<ActortvshowsLoadEvent>((event, emit) async {
      final tvActorShowsEither =
          await getActorShows(TvShowParams(event.actorId));

      tvActorShowsEither.fold(
        (error) => emit(ActortvshowsError()),
        (tvshows) => emit(ActortvshowsLoaded(tvshows)),
      );
    });
  }
}
