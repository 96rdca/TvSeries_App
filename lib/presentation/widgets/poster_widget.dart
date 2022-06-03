import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/presentation/widgets/image_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/tvshow_appbar.dart';

class Poster extends StatelessWidget {
  final TvShow tvShow;

  const Poster({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: tvShow.id!,
          child: ImageWidget(height: 600, image: tvShow.image?.original ?? ''),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                tvShow.name ?? '',
                style: Theme.of(context).textTheme.headline5,
              ),
            )),
        Positioned(
            left: 16,
            right: 16,
            top: AppBarTheme.of(context).toolbarHeight ?? 10,
            child: TvShowDetailAppBar(
              tvShow: tvShow,
              showLiked: true,
            ))
      ],
    );
  }
}
