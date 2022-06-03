import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_episode/tvshowepisode_bloc.dart';
import 'package:seriestv_jobcity/common/logger.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/episode_list_widget.dart';

class SeasonsWidget extends StatefulWidget {
  const SeasonsWidget({Key? key}) : super(key: key);

  @override
  State<SeasonsWidget> createState() => _SeasonsWidgetState();
}

class _SeasonsWidgetState extends State<SeasonsWidget>
    with TickerProviderStateMixin {
  final log = getLogger('Season Widget');

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvshowepisodeBloc, TvshowepisodeState>(
      builder: (context, state) {
        if (state is TvshowepisodeLoaded) {
          _tabController =
              TabController(length: state.tvSeasons.length, vsync: this);

          if (state.tvSeasons.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Text('No Seasons / Episodes found'),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.vulcan,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.bodyText2,
                        unselectedLabelColor: Colors.white,
                        tabs: state.tvSeasons
                            .map((e) => Tab(
                                  child: Text('Season ${e.season}'),
                                ))
                            .toList()),
                  ),
                  Expanded(
                    flex: 10,
                    child: TabBarView(
                      controller: _tabController,
                      children: state.tvSeasons
                          .map((e) => EpisodeListWidget(
                                tvShowEpisode: e.episode!,
                              ))
                          .toList(),
                    ),
                  ),
                ],
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
