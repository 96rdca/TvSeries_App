import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/favorite/favorite_bloc.dart';
import 'package:seriestv_jobcity/data/models/tvshow_detail_arguments.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/presentation/screens/detail_tvshow_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class FavoriteTvShowCardWidget extends StatelessWidget {
  final TvShow tvShow;
  const FavoriteTvShowCardWidget({Key? key, required this.tvShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: AppColor.vulcan, borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailTvShowScreen.routeName,
            arguments: TvShowDetailArguments(tvShow, true),
          ).then((value) => BlocProvider.of<FavoriteBloc>(context)
              .add(LoadFavoriteTvShowEvent()));
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent
                          ])),
                      child: CachedNetworkImage(
                        imageUrl: tvShow.image?.medium ?? '',
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
                        fit: BoxFit.cover,
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
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => BlocProvider.of<FavoriteBloc>(context)
                    .add(DeleteFavoriteTvShowEvent(tvShow.id!)),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.delete,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
