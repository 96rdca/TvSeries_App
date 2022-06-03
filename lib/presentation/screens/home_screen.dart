import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/search_tvactor/searchtvactor_bloc.dart';
import 'package:seriestv_jobcity/blocs/search_tvshow/searchtvshow_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_grid/tvshows_grid_bloc.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/searchs/search_tvactor.dart';
import 'package:seriestv_jobcity/presentation/searchs/search_tvshow.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/drawer.dart';
import 'package:seriestv_jobcity/presentation/widgets/tvshow_grid_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TvShowGridBloc tvshowsGridBloc;
  late SearchTvShowBloc searchTvShowBloc;
  late SearchTvActorBloc searchTvActorBloc;

  @override
  void initState() {
    super.initState();
    tvshowsGridBloc = getItInstance<TvShowGridBloc>();
    searchTvShowBloc = getItInstance<SearchTvShowBloc>();
    searchTvActorBloc = getItInstance<SearchTvActorBloc>();
    tvshowsGridBloc.add(TvShowsLoadEvent());
  }

  @override
  void dispose() {
    tvshowsGridBloc.close();
    searchTvShowBloc.close();
    searchTvActorBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: tvshowsGridBloc),
        BlocProvider.value(value: searchTvShowBloc),
        BlocProvider.value(value: searchTvActorBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.grey,
        drawer: const NavigationDrawer(),
        appBar: AppBar(title: const Text('Tv maze'), actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context,
                  delegate: CustomSearchTvShow(searchTvShowBloc)),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 24,
              )),
          IconButton(
              onPressed: () => showSearch(
                  context: context,
                  delegate: CustomSearchTvActor(searchTvActorBloc)),
              icon: const Icon(
                Icons.person_search,
                color: Colors.white,
                size: 24,
              ))
        ]),
        body: const TvShowGridWidget(),
      ),
    );
  }
}
