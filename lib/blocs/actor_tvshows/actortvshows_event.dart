part of 'actortvshows_bloc.dart';

abstract class ActortvshowsEvent extends Equatable {
  const ActortvshowsEvent();

  @override
  List<Object> get props => [];
}

class ActortvshowsLoadEvent extends ActortvshowsEvent {
  final int actorId;

  const ActortvshowsLoadEvent(this.actorId);

  @override
  List<Object> get props => [actorId];
}
