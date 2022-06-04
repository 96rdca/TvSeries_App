import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:seriestv_jobcity/blocs/authentication/authentication_cubit.dart';
import 'package:seriestv_jobcity/blocs/authentication/fingerprint_cubit.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/screens/home_screen.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/button.dart';
import 'package:seriestv_jobcity/presentation/widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthenticationCubit _authenticationCubit;
  late FingerprintCubit _fingerprintCubit;
  late TextEditingController _pinEditing;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _pinEditing = TextEditingController();
    _fingerprintCubit = getItInstance<FingerprintCubit>();
    _authenticationCubit = getItInstance<AuthenticationCubit>();
    _fingerprintCubit.isEnabledFingerPrint();
    _authenticationCubit.isSetPIN();
  }

  Future<void> authenticaFinger() async {
    final isAuthenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: false,
          biometricOnly: true,
        ));
    if (!mounted) return;

    if (!isAuthenticated) {
      return;
    }
    Navigator.popAndPushNamed(context, HomeScreen.routeName);
  }

  void validatePIN() async {
    final authenticate = await _authenticationCubit.check(_pinEditing.text);

    if (!mounted) return;

    if (!authenticate) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Incorrect PIN'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Navigator.popAndPushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FingerprintCubit>.value(value: _fingerprintCubit),
          BlocProvider<AuthenticationCubit>.value(value: _authenticationCubit),
        ],
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(height: 120),
              BlocBuilder<FingerprintCubit, bool>(
                builder: (context, fingerAuth) {
                  return BlocBuilder<AuthenticationCubit, bool>(
                    bloc: _authenticationCubit,
                    builder: (context, localAuth) {
                      if (localAuth) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextField(
                                controller: _pinEditing,
                                obscureText: true,
                                textAlign: TextAlign.center,
                                onEditingComplete: validatePIN,
                                style: Theme.of(context).textTheme.subtitle1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    label: const Text('PIN'),
                                    labelStyle:
                                        Theme.of(context).textTheme.subtitle1),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                              ),
                            ),
                            Button(
                              text: 'Access with PIN',
                              onPressed: () => validatePIN(),
                            )
                          ],
                        );
                      }
                      if (fingerAuth) {
                        return Button(
                          text: 'Authenticate with Fingerprint',
                          onPressed: () => authenticaFinger(),
                        );
                      }
                      if (!fingerAuth && !localAuth) {
                        return Button(
                          text: 'Continue to Home',
                          onPressed: () => Navigator.popAndPushNamed(
                              context, HomeScreen.routeName),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
