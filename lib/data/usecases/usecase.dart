import 'package:dartz/dartz.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}
