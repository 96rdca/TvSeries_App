import 'package:equatable/equatable.dart';

class TvShowParams extends Equatable {
  final int id;

  const TvShowParams(this.id);

  @override
  List<Object?> get props => [id];
}
