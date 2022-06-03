import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/tv_actor_model.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/actor_tvshows_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/image_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/tvshow_appbar.dart';

class ActorDetailScreen extends StatelessWidget {
  static const String routeName = '/actordetail';
  final TvActor tvActor;

  const ActorDetailScreen({Key? key, required this.tvActor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.grey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ImageWidget(
                      height: 550, image: tvActor.image?.original ?? ''),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tvActor.name ?? '',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Positioned(
                      left: 16,
                      right: 16,
                      top: AppBarTheme.of(context).toolbarHeight ?? 10,
                      child: const TvShowDetailAppBar(
                        tvShow: null,
                      ))
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Known For',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: ActorTvShowsWidget(actorId: tvActor.id!),
              ),
            ],
          ),
        ));
  }
}
