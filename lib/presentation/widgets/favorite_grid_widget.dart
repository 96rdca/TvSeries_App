import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/presentation/widgets/favorite_card_widget.dart';

class FavoriteTvShowGridView extends StatelessWidget {
  final List<TvShow> tvShows;

  const FavoriteTvShowGridView({Key? key, required this.tvShows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: tvShows.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 32,
          ),
          itemBuilder: (context, index) {
            return FavoriteTvShowCardWidget(tvShow: tvShows[index]);
          }),
    );
  }
}
