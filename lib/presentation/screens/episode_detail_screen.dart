import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/common/extensions/string_extensions.dart';
import 'package:seriestv_jobcity/data/models/tvshow_episode_model.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/image_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/tvshow_appbar.dart';

class EpisodeDetailScreen extends StatelessWidget {
  static const String routeName = '/episode';
  final TvShowEpisode tvShowEpisode;

  const EpisodeDetailScreen({Key? key, required this.tvShowEpisode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageWidget(
                    height: 300, image: tvShowEpisode.image?.original ?? ''),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tvShowEpisode.name ?? '',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Positioned(
                    left: 16,
                    right: 16,
                    top: AppBarTheme.of(context).toolbarHeight ?? 10,
                    child: const TvShowDetailAppBar(
                      tvShow: null,
                    ))
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Episode ${tvShowEpisode.number ?? 'Special'}, Season ${tvShowEpisode.season}',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${tvShowEpisode.rating?.average ?? 0} ⭐',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Text(
                tvShowEpisode.summary ?? '',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10.0),
                  Text('${tvShowEpisode.runtime.toString()} Minutes'),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      '${tvShowEpisode.airdate} ${tvShowEpisode.airtime!.parseTime()}'),
                  const SizedBox(width: 10.0),
                  const Icon(
                    Icons.date_range,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
