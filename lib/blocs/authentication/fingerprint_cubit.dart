import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/data/models/params/no_params.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/is_enable_finger.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/toggle_finger.dart';

class FingerprintCubit extends Cubit<bool> {
  final ToggleFinger toogleFinger;
  final IsEnabledFinger isEnabledFinger;

  FingerprintCubit({
    required this.toogleFinger,
    required this.isEnabledFinger,
  }) : super(false);

  void toggleFingerPrint() async {
    final eitherToggle = await toogleFinger(NoParams());
    eitherToggle.fold((l) => emit(false), (r) => emit(r));
  }

  void isEnabledFingerPrint() async {
    final eitherEnabled = await isEnabledFinger(NoParams());
    eitherEnabled.fold((l) => emit(false), (r) => emit(r));
  }
}
