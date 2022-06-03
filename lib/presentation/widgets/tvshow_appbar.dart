import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/favorite/favorite_bloc.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';

class TvShowDetailAppBar extends StatelessWidget {
  final TvShow? tvShow;
  final bool showLiked;

  const TvShowDetailAppBar(
      {Key? key, required this.tvShow, this.showLiked = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Visibility(
          visible: showLiked,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is IsFavoriteTvShow) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<FavoriteBloc>(context).add(
                    ToggleFavoriteTvShowEvent(
                      tvShow!,
                      state.isFavoriteMovie,
                    ),
                  ),
                  child: Icon(
                    state.isFavoriteMovie
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                );
              } else {
                return const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
