import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/search_tvactor/searchtvactor_bloc.dart';
import 'package:seriestv_jobcity/common/enums/apperror_type.dart';
import 'package:seriestv_jobcity/data/models/params/search_params.dart';
import 'package:seriestv_jobcity/presentation/screens/actor_detail_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_text.dart';
import 'package:seriestv_jobcity/presentation/widgets/app_error_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/search_card_widget.dart';

class CustomSearchTvActor extends SearchDelegate {
  final SearchTvActorBloc searchTvActorBloc;

  CustomSearchTvActor(this.searchTvActorBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.subtitle1,
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : Colors.white,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    searchTvActorBloc.add(SearchTermChangedEvent(query));

    return BlocBuilder(
      bloc: searchTvActorBloc,
      builder: (context, state) {
        if (state is SearchTvActorError) {
          return AppErroWidget(
              onPressed: () =>
                  searchTvActorBloc.add(SearchTermChangedEvent(query)),
              errorType: AppErrorType.api);
        } else if (state is SearchTvActorLoaded) {
          if (state.tvActors.isEmpty) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'No TV Show found, please search with another word',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.vulcanBodyText2,
              ),
            ));
          }

          return ListView.builder(
            itemCount: state.tvActors.length,
            itemBuilder: (context, index) {
              final tvActor = state.tvActors[index];

              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ActorDetailScreen.routeName,
                      arguments: tvActor);
                },
                child: SearchCard(
                    searchParams: SearchParams(
                  name: tvActor.name ?? '',
                  image: tvActor.image?.medium,
                  summary: '',
                )),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
