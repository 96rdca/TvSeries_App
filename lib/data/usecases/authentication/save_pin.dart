import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/pin_params.dart';
import 'package:seriestv_jobcity/data/repository/authentication_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class SavePIN extends UseCase<void, PinParams> {
  final AuthenticationRepository authenticationRepository;

  SavePIN(this.authenticationRepository);

  @override
  Future<Either<AppError, void>> call(PinParams params) async {
    return await authenticationRepository.savePIN(params.pin);
  }
}
