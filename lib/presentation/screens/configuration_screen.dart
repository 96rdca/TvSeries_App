import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:seriestv_jobcity/blocs/authentication/authentication_cubit.dart';
import 'package:seriestv_jobcity/blocs/authentication/fingerprint_cubit.dart';
import 'package:seriestv_jobcity/di/get_it.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/widgets/button.dart';

class ConfigurationScreen extends StatefulWidget {
  static const String routeName = '/configuration';

  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  late TextEditingController _pinEditing;
  late TextEditingController _newPinEditing;

  late AuthenticationCubit _authenticationCubit;
  late FingerprintCubit _fingerprintCubit;
  late bool isPINset;
  bool canEnabledBiometrics = false;

  LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    checkAvailableBiometrics();
    _pinEditing = TextEditingController();
    _newPinEditing = TextEditingController();

    _authenticationCubit = getItInstance<AuthenticationCubit>();
    _fingerprintCubit = getItInstance<FingerprintCubit>();
    _authenticationCubit.isSetPIN();
    _fingerprintCubit.isEnabledFingerPrint();
  }

  @override
  void dispose() {
    _newPinEditing.dispose();
    _pinEditing.dispose();

    super.dispose();
  }

  void checkAvailableBiometrics() async {
    final biometrics = await auth.getAvailableBiometrics();
    final canEnabled = biometrics.any((e) =>
        e == BiometricType.face ||
        e == BiometricType.fingerprint ||
        e == BiometricType.iris);

    setState(() {
      canEnabledBiometrics = canEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuration')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FingerprintCubit>.value(value: _fingerprintCubit),
          BlocProvider<AuthenticationCubit>.value(value: _authenticationCubit),
        ],
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              BlocBuilder<AuthenticationCubit, bool>(
                bloc: _authenticationCubit,
                builder: (context, show) {
                  if (show) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Button(
                          onPressed: () => modifyPIN(context),
                          text: 'Change PIN',
                        ),
                        Button(
                          onPressed: () => deletePin(context),
                          text: 'Delete PIN',
                        ),
                      ],
                    );
                  } else {
                    return Button(
                      onPressed: () => setPIN(context),
                      text: 'Set PIN',
                    );
                  }
                },
              ),
              Visibility(
                visible: canEnabledBiometrics,
                child: BlocBuilder<FingerprintCubit, bool>(
                  bloc: _fingerprintCubit,
                  builder: (context, isActive) {
                    return Button(
                      text: isActive
                          ? 'Disables Fingerprint'
                          : 'Enable Fingerprint',
                      onPressed: () => _fingerprintCubit.toggleFingerPrint(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setPIN(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _pinEditing.text = '';
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: pinSet,
                child: const Text('Save'),
              )
            ],
            title: Text('Set PIN',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please enter the PIN you would like, has to be of lenght 6',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.black),
                ),
                TextField(
                  controller: _pinEditing,
                  obscureText: true,
                  onEditingComplete: pinSet,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AppColor.vulcan),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                )
              ],
            ),
          );
        });
  }

  void deletePin(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _pinEditing.text = '';
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: deletedPIN, child: const Text('Delete'))
            ],
            title: Text('Delete PIN',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please enter the current PIN',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.black),
                ),
                TextField(
                  controller: _pinEditing,
                  obscureText: true,
                  onEditingComplete: deletedPIN,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AppColor.vulcan),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                )
              ],
            ),
          );
        });
  }

  void modifyPIN(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _pinEditing.text = '';
                      _newPinEditing.text = '';
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: modifiedPIN, child: const Text('Save'))
            ],
            title: Text('Set PIN',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please enter the PIN you would like, has to be of lenght 6',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.black),
                ),
                TextField(
                  controller: _pinEditing,
                  obscureText: true,
                  onEditingComplete: () {},
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AppColor.vulcan),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Old PIN')),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
                TextField(
                  controller: _newPinEditing,
                  obscureText: true,
                  onEditingComplete: modifiedPIN,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AppColor.vulcan),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('New PIN')),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                )
              ],
            ),
          );
        });
  }

  void pinSet() async {
    FocusScope.of(context).unfocus();

    if (_pinEditing.text.isEmpty) {
      _showSnackBar('Must complete the field', Colors.redAccent);
      return;
    }

    if (_pinEditing.text.length < 6) {
      _showSnackBar('PIN length must be 6', Colors.redAccent);
      return;
    }

    final isSave = await _authenticationCubit.storePIN(_pinEditing.text);
    if (!mounted) return;

    if (isSave) {
      _showSnackBar('PIN set successfully', Colors.green);
    } else {
      _showSnackBar('Something went wrong...', Colors.red);
    }
    Navigator.pop(context);
  }

  void modifiedPIN() async {
    FocusScope.of(context).unfocus();

    if (_pinEditing.text.isEmpty || _newPinEditing.text.isEmpty) {
      _showSnackBar('Must complete both fields', Colors.redAccent);
      return;
    }

    if (_pinEditing.text.length < 6 || _newPinEditing.text.length < 6) {
      _showSnackBar('PIN length must be 6', Colors.redAccent);
      return;
    }

    final isSave = await _authenticationCubit.modifyPIN(
        _pinEditing.text, _newPinEditing.text);
    if (!mounted) return;

    if (isSave) {
      _showSnackBar('PIN modified successfully', Colors.green);
    } else {
      _showSnackBar('Something went wrong...', Colors.red);
    }
    Navigator.pop(context);
  }

  void deletedPIN() async {
    FocusScope.of(context).unfocus();

    if (_pinEditing.text.isEmpty) {
      _showSnackBar('Must complete the field', Colors.redAccent);
      return;
    }

    if (_pinEditing.text.length < 6) {
      _showSnackBar('PIN length must be 6', Colors.redAccent);
      return;
    }

    final isSave = await _authenticationCubit.erasePIN(_pinEditing.text);
    if (!mounted) return;

    if (isSave) {
      _showSnackBar('PIN deleted successfully', Colors.green);
    } else {
      _showSnackBar('Something went wrong...', Colors.red);
    }

    Navigator.pop(context);
  }

  void _showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
    ));
  }
}
