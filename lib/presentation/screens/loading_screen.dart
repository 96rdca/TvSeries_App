import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/loading/loading_cubit.dart';
import 'package:seriestv_jobcity/presentation/widgets/loading_widget.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;
  const LoadingScreen({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LoadingCubit, bool>(
        builder: (context, shouldShow) {
          return Stack(
            fit: StackFit.expand,
            children: [
              screen,
              if (shouldShow)
                Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: const Center(child: LoadingCircle(size: 200)),
                )
            ],
          );
        },
      ),
    );
  }
}
