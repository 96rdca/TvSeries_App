import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/tvshow_grid/tvshows_grid_bloc.dart';
import 'package:seriestv_jobcity/presentation/widgets/app_error_widget.dart';
import 'package:seriestv_jobcity/presentation/widgets/tvshow_card_widget.dart';

class TvShowGridWidget extends StatefulWidget {
  const TvShowGridWidget({Key? key}) : super(key: key);

  @override
  State<TvShowGridWidget> createState() => _TvShowGridWidgetState();
}

class _TvShowGridWidgetState extends State<TvShowGridWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowGridBloc, TvshowsGridState>(
      // bloc: tvshowsGridBloc,
      builder: (context, state) {
        if (state is TvshowsGridLoaded) {
          return GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.6),
              itemCount: state.tvShows.length,
              itemBuilder: (context, index) {
                return TvShowCardWidget(tvShow: state.tvShows[index]);
              });
        } else if (state is TvshowsGridError) {
          return AppErroWidget(
            onPressed: () => BlocProvider.of<TvShowGridBloc>(context)
                .add(TvShowsLoadEvent()),
            errorType: state.errorType,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<TvShowGridBloc>(context).add(TvShowGridLoadPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }
}
