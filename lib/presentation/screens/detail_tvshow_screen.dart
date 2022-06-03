import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/favorite/favorite_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_detail/tvshowdetail_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_episode/tvshowepisode_bloc.dart';
import 'package:seriestv_jobcity/data/models/tvshow_detail_arguments.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/poster_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/schedule_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/seasons_widget.dart';

class DetailTvShowScreen extends StatefulWidget {
  static const String routeName = '/detail';

  final TvShowDetailArguments tvShowDetailArguments;

  const DetailTvShowScreen({Key? key, required this.tvShowDetailArguments})
      : super(key: key);

  @override
  State<DetailTvShowScreen> createState() => _DetailTvShowScreenState();
}

class _DetailTvShowScreenState extends State<DetailTvShowScreen> {
  late TvShowDetailBloc _tvShowDetailBloc;
  late FavoriteBloc _favoriteBloc;
  late TvshowepisodeBloc _tvShowEpisodeBloc;

  @override
  void initState() {
    super.initState();
    _tvShowDetailBloc = getItInstance<TvShowDetailBloc>();
    _tvShowEpisodeBloc = _tvShowDetailBloc.tvshowepisodeBloc;
    _favoriteBloc = _tvShowDetailBloc.favoriteBloc;

    _tvShowDetailBloc.add(TvShowDetailLoadEvent(
        widget.tvShowDetailArguments.tvShow,
        widget.tvShowDetailArguments.isFromSaved));
  }

  @override
  void dispose() {
    _tvShowDetailBloc.close();
    _tvShowEpisodeBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _tvShowDetailBloc),
          BlocProvider.value(value: _tvShowEpisodeBloc),
          BlocProvider.value(value: _favoriteBloc),
        ],
        child: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
          builder: (context, state) {
            if (state is TvShowDetailLoaded) {
              return NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (BuildContext contextNested, active) {
                  return [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Poster(tvShow: state.tvShow),
                      Wrap(
                          direction: Axis.horizontal,
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: state.tvShow.genres!
                              .map<Chip>((x) => Chip(
                                    backgroundColor: AppColor.vulcan,
                                    label: Text(
                                      x,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ))
                              .toList()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Text(
                          state.tvShow.summary ?? '',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Visibility(
                        visible: state.tvShow.schedule!.days!.isNotEmpty &&
                            state.tvShow.schedule!.time!.isNotEmpty,
                        child: ScheduleWidget(
                          schedule: state.tvShow.schedule!,
                        ),
                      ),
                    ])),
                  ];
                },
                body: const SeasonsWidget(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
