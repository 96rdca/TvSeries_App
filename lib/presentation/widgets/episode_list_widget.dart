import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/tvshow_episode_model.dart';
import 'package:seriestv_jobcity/presentation/screens/episode_detail_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class EpisodeListWidget extends StatelessWidget {
  final List<TvShowEpisode> tvShowEpisode;

  const EpisodeListWidget({Key? key, required this.tvShowEpisode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tvShowEpisode.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tvEpisode = tvShowEpisode[index];
          return ListTile(
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppColor.vulcan,
              size: 20,
            ),
            onTap: () => Navigator.of(context)
                .pushNamed(EpisodeDetailScreen.routeName, arguments: tvEpisode),
            title: Text(
                '${tvEpisode.number ?? 'Special'}. ${tvEpisode.name ?? ''}'),
          );
        });
  }
}
