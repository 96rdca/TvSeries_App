import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/data/models/params/no_params.dart';
import 'package:seriestv_jobcity/data/models/params/pin_params.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/change_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/check_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/delete_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/is_save_pin.dart';
import 'package:seriestv_jobcity/data/usecases/authentication/save_pin.dart';

class AuthenticationCubit extends Cubit<bool> {
  final SavePIN savePIN;
  final DeletePIN deletePIN;
  final CheckPIN checkPIN;
  final IsSavePIN isSavePIN;
  final ChangePIN changePIN;

  AuthenticationCubit({
    required this.savePIN,
    required this.deletePIN,
    required this.checkPIN,
    required this.isSavePIN,
    required this.changePIN,
  }) : super(false);

  void isSetPIN() async {
    final isSave = await isSavePIN(NoParams());
    return isSave.fold((l) => emit(false), (r) => emit(r));
  }

  Future<bool> erasePIN(String pin) async {
    final canDelete = await check(pin);
    if (!canDelete) return canDelete;

    final isDeleted = await deletePIN(NoParams());
    isSetPIN();
    return isDeleted.fold((l) => false, (r) => true);
  }

  Future<bool> storePIN(String pin) async {
    final isSave = await savePIN(PinParams(pin));
    isSetPIN();
    return isSave.fold((error) => false, (x) => true);
  }

  Future<bool> modifyPIN(String oldPin, String newPin) async {
    final canModify = await check(oldPin);

    if (!canModify) return canModify;

    final isModify = await changePIN(PinParams(newPin));
    return isModify.fold((error) => false, (success) => success);
  }

  Future<bool> check(String pin) async {
    final isSame = await checkPIN(PinParams(pin));
    return isSame.fold((l) => false, (r) => r);
  }
}
