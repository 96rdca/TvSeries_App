import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/no_params.dart';
import 'package:seriestv_jobcity/data/repository/authentication_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class IsEnabledFinger extends UseCase<bool, NoParams> {
  final AuthenticationRepository authenticationRepository;

  IsEnabledFinger(this.authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(NoParams params) async {
    return await authenticationRepository.isEnableFinger();
  }
}
