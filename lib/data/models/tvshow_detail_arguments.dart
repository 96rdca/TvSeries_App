import 'package:seriestv_jobcity/data/models/tvshow_model.dart';

class TvShowDetailArguments {
  final TvShow tvShow;
  final bool isFromSaved;

  const TvShowDetailArguments(this.tvShow, this.isFromSaved);
}
