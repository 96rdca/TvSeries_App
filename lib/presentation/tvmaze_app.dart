import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/authentication/authentication_cubit.dart';
import 'package:seriestv_jobcity/blocs/authentication/fingerprint_cubit.dart';
import 'package:seriestv_jobcity/blocs/loading/loading_cubit.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/screens/home_screen.dart';
import 'package:seriestv_jobcity/presentation/screens/loading_screen.dart';
import 'package:seriestv_jobcity/presentation/router.dart';
import 'package:seriestv_jobcity/presentation/screens/login_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_text.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class TvMazeApp extends StatefulWidget {
  const TvMazeApp({Key? key}) : super(key: key);

  @override
  State<TvMazeApp> createState() => _TvMazeAppState();
}

class _TvMazeAppState extends State<TvMazeApp> {
  late LoadingCubit _loadingCubit;
  late AuthenticationCubit _authenticationCubit;
  late FingerprintCubit _fingerprintCubit;
  @override
  void initState() {
    super.initState();
    _loadingCubit = getItInstance<LoadingCubit>();
    _authenticationCubit = getItInstance<AuthenticationCubit>();
    _fingerprintCubit = getItInstance<FingerprintCubit>();
    _authenticationCubit.isSetPIN();
    _fingerprintCubit.isEnabledFingerPrint();
  }

  @override
  void dispose() {
    _loadingCubit.close();
    _authenticationCubit.close();
    _fingerprintCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
        BlocProvider<AuthenticationCubit>.value(value: _authenticationCubit),
        BlocProvider<FingerprintCubit>.value(value: _fingerprintCubit),
      ],
      child: BlocBuilder<AuthenticationCubit, bool>(
        builder: (context, isEnabledPIN) {
          return BlocBuilder<FingerprintCubit, bool>(
            builder: (context, isEnabledFinger) {
              return MaterialApp(
                title: 'Tv Maze',
                theme: ThemeData(
                    primaryColor: AppColor.blue,
                    textTheme: ThemeText.getTextTheme(),
                    appBarTheme:
                        const AppBarTheme(backgroundColor: AppColor.grey)),
                initialRoute: handleLogin(isEnabledFinger, isEnabledPIN),
                builder: (context, child) => LoadingScreen(screen: child!),
                onGenerateRoute: generateRoute,
              );
            },
          );
        },
      ),
    );
  }

  String handleLogin(bool isEnabledFinger, bool isEnabledPIN) {
    if (isEnabledFinger || isEnabledPIN) {
      return LoginScreen.routeName;
    } else {
      return HomeScreen.routeName;
    }
  }
}
