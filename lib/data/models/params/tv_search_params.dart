import 'package:equatable/equatable.dart';

class TvSearchParams extends Equatable {
  final String searchTerm;

  const TvSearchParams({required this.searchTerm});

  @override
  List<Object?> get props => [searchTerm];
}
