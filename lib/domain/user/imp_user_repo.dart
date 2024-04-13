import 'package:cash_ctrl/domain/user/entity/user.dart';
import 'package:dartz/dartz.dart';

abstract class ImpUserRepository extends IBaseRepository<User> {}

abstract class IBaseRepository<T> {
  Future<Either<String, User>> update(Map<String, dynamic> data);
}
