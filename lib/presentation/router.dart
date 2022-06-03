import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/common/logger.dart';
import 'package:seriestv_jobcity/data/models/tv_actor_model.dart';
import 'package:seriestv_jobcity/data/models/tvshow_detail_arguments.dart';
import 'package:seriestv_jobcity/data/models/tvshow_episode_model.dart';
import 'package:seriestv_jobcity/presentation/screens/actor_detail_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/configuration_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/detail_tvshow_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/episode_detail_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/favorite_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/home_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var log = getLogger('Router');

  log.i('Navigate to ${settings.name} ${settings.arguments}');

  switch (settings.name) {
    case HomeScreen.routeName:
      return _getPageRoute(settings, const HomeScreen());

    case DetailTvShowScreen.routeName:
      return _getPageRoute(
        settings,
        DetailTvShowScreen(
            tvShowDetailArguments: settings.arguments as TvShowDetailArguments),
      );

    case EpisodeDetailScreen.routeName:
      return _getPageRoute(
        settings,
        EpisodeDetailScreen(tvShowEpisode: settings.arguments as TvShowEpisode),
      );

    case ActorDetailScreen.routeName:
      return _getPageRoute(
        settings,
        ActorDetailScreen(tvActor: settings.arguments as TvActor),
      );

    case FavoriteScreen.routeName:
      return _getPageRoute(settings, const FavoriteScreen());

    case LoginScreen.routeName:
      return _getPageRoute(settings, const LoginScreen());

    case ConfigurationScreen.routeName:
      return _getPageRoute(settings, const ConfigurationScreen());

    default:
      return _getPageRoute(
          const RouteSettings(),
          const Scaffold(
            body: Center(child: Text('Route not defined')),
          ));
  }
}

PageRoute _getPageRoute(RouteSettings setting, Widget viewToShow) {
  return MaterialPageRoute(settings: setting, builder: (_) => viewToShow);
}
