import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/authentication/authentication_cubit.dart';
import 'package:seriestv_jobcity/blocs/authentication/fingerprint_cubit.dart';
import 'package:seriestv_jobcity/blocs/search_tvactor/searchtvactor_bloc.dart';
import 'package:seriestv_jobcity/blocs/search_tvshow/searchtvshow_bloc.dart';
import 'package:seriestv_jobcity/presentation/screens/configuration_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/favorite_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/login_screen.dart';
import 'package:seriestv_jobcity/presentation/searchs/search_tvactor.dart';
import 'package:seriestv_jobcity/presentation/searchs/search_tvshow.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/drawer_item.dart';
import 'package:seriestv_jobcity/presentation/widgets/logo.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Logo(height: 60),
            const SizedBox(height: 10),
            DrawerListItem(
                icon: Icons.search,
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearchTvShow(
                          BlocProvider.of<SearchTvShowBloc>(context)));
                },
                title: 'Search by Tv Show'),
            DrawerListItem(
                icon: Icons.person_search,
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearchTvActor(
                          BlocProvider.of<SearchTvActorBloc>(context)));
                },
                title: 'Search by Actor'),
            DrawerListItem(
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.popAndPushNamed(context, FavoriteScreen.routeName);
                },
                title: 'Favorites'),
            Visibility(
              visible: BlocProvider.of<AuthenticationCubit>(context).state ||
                  BlocProvider.of<FingerprintCubit>(context).state,
              child: DrawerListItem(
                  icon: Icons.logout_outlined,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, LoginScreen.routeName);
                  },
                  title: 'Log Out'),
            ),
            const Spacer(),
            DrawerListItem(
                icon: Icons.settings,
                onPressed: () {
                  Navigator.popAndPushNamed(
                      context, ConfigurationScreen.routeName);
                },
                title: 'Configuration'),
          ],
        ),
      ),
    );
  }
}
