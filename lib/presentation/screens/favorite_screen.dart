import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/favorite/favorite_bloc.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/favorite_grid_widget.dart';

class FavoriteScreen extends StatefulWidget {
  static const String routeName = '/favorite';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc _favoriteBloc;
  bool isOrder = false;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getItInstance<FavoriteBloc>();
    _favoriteBloc.add(LoadFavoriteTvShowEvent());
  }

  @override
  void dispose() {
    _favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _favoriteBloc,
      child: Scaffold(
        backgroundColor: AppColor.grey,
        appBar: AppBar(
          title: const Text('Favorites Tv Shows'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isOrder = !isOrder;
                  });
                  if (isOrder) {
                    // A -Z
                    _favoriteBloc.add(SortFavoriteTvShowEvent(!isOrder));
                  } else {
                    // Z- A
                    _favoriteBloc.add(SortFavoriteTvShowEvent(!isOrder));
                  }
                },
                icon: Image.asset('assets/images/a-z.png'))
          ],
        ),
        body: BlocBuilder(
          bloc: _favoriteBloc,
          builder: (context, state) {
            if (state is FavoriteTvShowLoaded) {
              if (state.tvShows.isEmpty) {
                return Center(
                  child: Text(
                    'No Favorite Tv Show',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FavoriteTvShowGridView(
                  tvShows: state.tvShows,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
