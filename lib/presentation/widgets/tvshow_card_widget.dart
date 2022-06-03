import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/tvshow_detail_arguments.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/presentation/screens/detail_tvshow_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class TvShowCardWidget extends StatelessWidget {
  final TvShow tvShow;
  const TvShowCardWidget({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(DetailTvShowScreen.routeName,
          arguments: TvShowDetailArguments(tvShow, false)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
        decoration: BoxDecoration(
            color: AppColor.vulcan, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: tvShow.id!,
                  child: CachedNetworkImage(
                    imageUrl: tvShow.image!.original!,
                    fit: BoxFit.cover,
                    placeholder: (context, text) {
                      return LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.black.withOpacity(0.1),
                      );
                    },
                    placeholderFadeInDuration:
                        const Duration(milliseconds: 400),
                    errorWidget: (context, error, stack) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        size: 100,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                tvShow.name!,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
