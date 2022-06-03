import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/no_params.dart';
import 'package:seriestv_jobcity/data/repository/authentication_repository.dart';
import 'package:seriestv_jobcity/data/usecases/usecase.dart';

class DeletePIN extends UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  DeletePIN(this.authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return await authenticationRepository.deletePIN();
  }
}
