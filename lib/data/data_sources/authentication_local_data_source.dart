import 'package:hive/hive.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> savePIN(String pin);
  Future<void> deletePIN();
  Future<bool> validatePIN(String pin);
  Future<void> changePIN(String pin);
  Future<bool> isPINsave();
  Future<bool> toggleFingerPrint();
  Future<bool> isEnabledFingerPrint();
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  @override
  Future<void> deletePIN() async {
    final authBox = await Hive.openBox('authBox');
    authBox.delete('pin');
  }

  @override
  Future<void> savePIN(String pin) async {
    final authBox = await Hive.openBox('authBox');
    authBox.put('pin', pin);
  }

  @override
  Future<bool> validatePIN(String pin) async {
    final authBox = await Hive.openBox('authBox');
    final savePin = authBox.get('pin');
    return pin == savePin;
  }

  @override
  Future<bool> isPINsave() async {
    final authBox = await Hive.openBox('authBox');
    final savePin = authBox.get('pin');
    final hasAnything = savePin == null ? false : savePin.toString().isNotEmpty;
    return hasAnything;
  }

  @override
  Future<void> changePIN(String pin) async {
    await deletePIN();
    await savePIN(pin);
  }

  @override
  Future<bool> toggleFingerPrint() async {
    final authBox = await Hive.openBox('authBox');
    if (authBox.get('finger') == null) {
      authBox.put('finger', true);
      return true;
    } else {
      authBox.delete('finger');
      return false;
    }
  }

  @override
  Future<bool> isEnabledFingerPrint() async {
    final authBox = await Hive.openBox('authBox');
    final isActive = authBox.get('finger');
    return isActive == null ? false : isActive!;
  }
}
