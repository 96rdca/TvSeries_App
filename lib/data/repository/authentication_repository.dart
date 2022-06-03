import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/common/enums/apperror_type.dart';
import 'package:seriestv_jobcity/common/logger.dart';
import 'package:seriestv_jobcity/data/data_sources/authentication_local_data_source.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, bool>> savePIN(String pin);
  Future<Either<AppError, bool>> deletePIN();
  Future<Either<AppError, bool>> validatePIN(String pin);
  Future<Either<AppError, bool>> changePIN(String pin);
  Future<Either<AppError, bool>> isPINsave();
  Future<Either<AppError, bool>> toggleFinger();
  Future<Either<AppError, bool>> isEnableFinger();
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final log = getLogger('AuthenticationRepositoryImpl');
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl(this.authenticationLocalDataSource);

  @override
  Future<Either<AppError, bool>> deletePIN() async {
    try {
      await authenticationLocalDataSource.deletePIN();
      return const Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> isPINsave() async {
    try {
      final response = await authenticationLocalDataSource.isPINsave();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> savePIN(String pin) async {
    try {
      await authenticationLocalDataSource.savePIN(pin);
      return const Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> validatePIN(String pin) async {
    try {
      final response = await authenticationLocalDataSource.validatePIN(pin);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> changePIN(String pin) async {
    try {
      await authenticationLocalDataSource.changePIN(pin);
      return const Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> isEnableFinger() async {
    try {
      final response =
          await authenticationLocalDataSource.isEnabledFingerPrint();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> toggleFinger() async {
    try {
      final response = await authenticationLocalDataSource.toggleFingerPrint();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
