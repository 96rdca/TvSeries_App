import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/pin_params.dart';
import 'package:seriestv_jobcity/data/repository/authentication_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class CheckPIN extends UseCase<bool, PinParams> {
  final AuthenticationRepository authenticationRepository;

  CheckPIN(this.authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(PinParams params) async {
    return await authenticationRepository.validatePIN(params.pin);
  }
}
