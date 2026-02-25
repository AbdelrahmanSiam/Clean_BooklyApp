import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase <T, Parameters>{
  Future <Either<Failure , T>> call([Parameters param]);
}
class NoParameters{}