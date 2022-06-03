import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/search_tvshow/searchtvshow_bloc.dart';
import 'package:seriestv_jobcity/common/enums/apperror_type.dart';
import 'package:seriestv_jobcity/data/models/params/search_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_detail_arguments.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/presentation/screens/detail_tvshow_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_text.dart';
import 'package:seriestv_jobcity/presentation/widgets/app_error_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/search_card_widget.dart';

class CustomSearchTvShow extends SearchDelegate {
  final SearchTvShowBloc searchTvShowBloc;

  CustomSearchTvShow(this.searchTvShowBloc);

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
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear,
            color: query.isEmpty ? Colors.grey : Colors.white),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () => close(context, null),
      child: const Icon(Icons.arrow_back_ios, size: 24),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchTvShowBloc.add(SearchTermChangedEvent(query));

    return BlocBuilder(
      bloc: searchTvShowBloc,
      builder: (context, state) {
        if (state is SearchTvShowError) {
          return AppErroWidget(
              onPressed: () =>
                  searchTvShowBloc.add(SearchTermChangedEvent(query)),
              errorType: AppErrorType.api);
        } else if (state is SearchTvShowLoaded) {
          if (state.tvShows.isEmpty) {
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
            itemCount: state.tvShows.length,
            itemBuilder: (context, index) {
              final tvShow = state.tvShows[index];

              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(DetailTvShowScreen.routeName,
                      arguments:
                          TvShowDetailArguments(TvShow(id: tvShow.id), true));
                },
                child: SearchCard(
                  searchParams: SearchParams(
                    name: tvShow.name ?? '',
                    image: tvShow.image?.medium,
                    summary: tvShow.summary,
                  ),
                ),
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
