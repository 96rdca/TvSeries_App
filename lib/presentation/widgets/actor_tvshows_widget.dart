import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/actor_tvshows/actortvshows_bloc.dart';
import 'package:seriestv_jobcity/data/models/tvshow_detail_arguments.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/screens/detail_tvshow_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class ActorTvShowsWidget extends StatefulWidget {
  final int actorId;
  const ActorTvShowsWidget({Key? key, required this.actorId}) : super(key: key);

  @override
  State<ActorTvShowsWidget> createState() => _ActorTvShowsWidgetState();
}

class _ActorTvShowsWidgetState extends State<ActorTvShowsWidget> {
  late ActortvshowsBloc _actortvshowsBloc;

  @override
  void initState() {
    super.initState();
    _actortvshowsBloc = getItInstance<ActortvshowsBloc>();
    _actortvshowsBloc.add(ActortvshowsLoadEvent(widget.actorId));
  }

  @override
  void dispose() {
    _actortvshowsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActortvshowsBloc, ActortvshowsState>(
      bloc: _actortvshowsBloc,
      builder: (context, state) {
        if (state is ActortvshowsLoaded) {
          if (state.tvshows.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('No Tv Shows found for this actor/person'),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 15.0,
                children: state.tvshows
                    .map((e) => GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              DetailTvShowScreen.routeName,
                              arguments: TvShowDetailArguments(e, false)),
                          child: Container(
                            height: 280,
                            decoration: BoxDecoration(
                                color: AppColor.vulcan,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: [
                              Expanded(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                          imageUrl: e.image?.medium ?? ''))),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  e.name!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              )
                            ]),
                          ),
                        ))
                    .toList(),
              ),
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
